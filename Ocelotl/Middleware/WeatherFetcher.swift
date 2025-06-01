//
//  WeatherFetcher.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import Foundation

public struct HourWeather: Identifiable {
    public let id = UUID()
    public let time: String
    public let date: Date
    public let temperature: Double
    public let precipitation: Double
    public let windSpeed: Double
    public let icon: String
}

public struct DayWeather: Identifiable {
    public let id = UUID()
    public let date: Date
    public let maxTemperature: Double
    public let precipitation: Double
    public let windSpeed: Double
    public let icon: String
}

public class WeatherFetcher: ObservableObject {
    @Published var currentWeatherSymbol: String?
    @Published var temperature: Double?
    @Published var minTemperature: Double?
    @Published var maxTemperature: Double?
    @Published var currentWindSpeed: Double?
    @Published var currentWindGust: Double?
    @Published var windDirection: Double?
    @Published var currentPrecipitation: Double?
    @Published var dailyPrecipitation: Double?
    @Published var currentHumidity: Double?
    @Published var hourlyWeather: [HourWeather] = []
    @Published var dailyWeather: [DayWeather] = []
    
    func fetchWeather(latitude: Double, longitude: Double) {
        guard let url = URL(string: "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=\(latitude)&lon=\(longitude)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Ocelotl/1.0 krzysieklam@outlook.com", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    DispatchQueue.main.async {
                        if let next1hrs = decoded.properties.timeseries.first?.data.next_1_hours {
                            self.currentWeatherSymbol = next1hrs.summary?.symbol_code
                            self.currentPrecipitation = next1hrs.details?.precipitation_amount
                        }
                        if let details = decoded.properties.timeseries.first?.data.instant.details {
                            self.temperature = details.air_temperature
                            self.currentWindSpeed = details.wind_speed
                            self.currentWindGust = details.wind_speed_of_gust
                            self.windDirection = details.wind_from_direction
                            self.currentHumidity = details.relative_humidity
                        }
                        
                        let today = Calendar.current.startOfDay(for: Date())
                        if let range = self.temperatureRange(for: today, in: decoded.properties.timeseries) {
                            self.minTemperature = range.min
                            self.maxTemperature = range.max
                        }
                        self.dailyPrecipitation = self.totalPrecipitation(for: today, in: decoded.properties.timeseries)
                        
                        self.buildHourlyForecast(from: decoded.properties.timeseries)
                        self.buildDailyForecast(from: decoded.properties.timeseries)
                    
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            } else if let error = error {
                print("Request error: \(error)")
            }
        }.resume()
    }
    
    private func temperatureRange(for date: Date, in timeseries: [TimeSeries]) -> (min: Double, max: Double)? {
        let calendar = Calendar(identifier: .gregorian)
        
        // Ustaw 00:00 tego dnia
        guard let startOfDay = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: date)),
              let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else {
            return nil
        }
        
        // Filtruj dane tylko z tego dnia
        let filteredTemps = timeseries.compactMap { entry -> Double? in
            guard let entryDate = entry.time.toDate() else { return nil }
            guard entryDate >= startOfDay && entryDate < endOfDay else { return nil }
            return entry.data.instant.details.air_temperature
        }
        
        guard let minTemp = filteredTemps.min(),
              let maxTemp = filteredTemps.max() else {
            return nil
        }
        
        return (min: minTemp, max: maxTemp)
    }
    
    private func totalPrecipitation(for date: Date, in timeseries: [TimeSeries]) -> Double {
        let calendar = Calendar(identifier: .gregorian)
        
        guard let startOfDay = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: date)),
              let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else {
            return 0.0
        }
        
        let dailyPrecip = timeseries.compactMap { entry -> Double? in
            guard let entryDate = entry.time.toDate(),
                  entryDate >= startOfDay && entryDate < endOfDay else {
                return nil
            }
            
            // Zbieramy opady z prognoz godzinnych
            return entry.data.next_1_hours?.details?.precipitation_amount
        }
        
        return dailyPrecip.reduce(0, +)
    }
    
    private func buildHourlyForecast(from timeseries: [TimeSeries]) {
        var hourly: [HourWeather] = []
        
        for entry in timeseries.prefix(48) { // Możesz też użyć .filter(...)
            guard
                let date = entry.time.toDate(),
                let temp = entry.data.instant.details.air_temperature,
                let icon = entry.data.next_1_hours?.summary?.symbol_code,
                let precip = entry.data.next_1_hours?.details?.precipitation_amount,
                let wind = entry.data.instant.details.wind_speed
            else { continue }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            
            let timeString = formatter.string(from: date)
            
            hourly.append(HourWeather(
                time: timeString,
                date: date,
                temperature: temp,
                precipitation: precip,
                windSpeed: wind,
                icon: sfSymbol(for: icon)
            ))
        }
        
        DispatchQueue.main.async {
            self.hourlyWeather = hourly
        }
    }
    
    private func buildDailyForecast(from timeseries: [TimeSeries]) {
        let calendar = Calendar(identifier: .gregorian)
        var grouped: [Date: [TimeSeries]] = [:]
        
        for entry in timeseries {
            guard let date = entry.time.toDate() else { continue }
            let dayStart = calendar.startOfDay(for: date)
            grouped[dayStart, default: []].append(entry)
        }
        
        var daily: [DayWeather] = []
        
        for (date, entries) in grouped.sorted(by: { $0.key < $1.key }).prefix(7) {
            let temps = entries.compactMap { $0.data.instant.details.air_temperature }
            let precs = entries.compactMap { $0.data.next_1_hours?.details?.precipitation_amount }
            
            let icon = entries.first?.data.next_1_hours?.summary?.symbol_code ?? "cloud"
            
            let maxTemp = temps.max() ?? 0
            let totalPrecip = precs.reduce(0, +)
            
            let winds = entries.compactMap { $0.data.instant.details.wind_speed }
            let maxWind = winds.max() ?? 0.0
            
            daily.append(DayWeather(
                date: date,
                maxTemperature: maxTemp,
                precipitation: totalPrecip,
                windSpeed: maxWind,
                icon: sfSymbol(for: icon)
            ))
        }
        
        DispatchQueue.main.async {
            self.dailyWeather = daily
        }
    }
    
    private func sfSymbol(for yrSymbol: String) -> String {
        switch yrSymbol {
        case let s where s.contains("fair_day"):
            return "sun.max"
        case let s where s.contains("clearsky"):
            return "sun.max"
        case let s where s.contains("partlycloudy"):
            return "cloud.sun"
        case "cloudy":
            return "cloud"
        case "cloud":
            return "cloud"
        case let s where s.contains("lightrain"):
            return "cloud.drizzle"
        case "rain":
            return "cloud.rain"
        case "heavyrain":
            return "cloud.heavyrain"
        case let s where s.contains("snow"):
            return "snow"
        case "fog":
            return "cloud.fog"
        case let s where s.contains("thunder"):
            return "cloud.bolt.rain"
        case "rainshowers_day":
            return "cloud.rain"
        case "fair_night":
            return "moon.stars"
        default:
            print(yrSymbol)
            return "questionmark"
        }
    }

}
