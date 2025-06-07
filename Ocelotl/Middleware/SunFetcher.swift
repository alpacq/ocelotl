//
//  SunFetcher.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 31/05/2025.
//

import Foundation
import CoreLocation

class SunFetcher: ObservableObject {
    private var sunrise: Date?
    var sunset: Date?
    private var dawn: Date?
    private var twilight: Date?
    private var goldenHourMorningEnd: Date?
    private var goldenHourEveningStart: Date?
    
    @Published var sunriseString: String = ""
    @Published var sunsetString: String = ""
    @Published var dawnString: String = ""
    @Published var twilightString: String = ""
    @Published var goldenHourMorningEndString: String = ""
    @Published var goldenHourEveningStartString: String = ""
    
    func fetchPhases(latitude: Double, longitude: Double, date: Date = Date()) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        
        guard let url = URL(string: "https://api.sunrise-sunset.org/json?lat=\(latitude)&lng=\(longitude)&formatted=0&date=\(dateString)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Sun API error: \(error?.localizedDescription ?? "unknown")")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(SunResponse.self, from: data)
                
                self.fetchTimeZone(latitude: latitude, longitude: longitude) { timeZone in
                    guard let timeZone = timeZone else {
                        print("Could not fetch time zone")
                        return
                    }
                    
                    let formatter = DateFormatter()
                    formatter.locale = Locale(identifier: "en_US_POSIX")
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
                    
                    let displayFormatter = DateFormatter()
                    displayFormatter.locale = Locale(identifier: "en_US_POSIX")
                    displayFormatter.timeZone = timeZone
                    displayFormatter.dateFormat = "HH:mm"
                    
                    DispatchQueue.main.async {
                        self.sunrise = formatter.date(from: decoded.results.sunrise)
                        self.sunset = formatter.date(from: decoded.results.sunset)
                        self.dawn = formatter.date(from: decoded.results.civil_twilight_begin)
                        self.twilight = formatter.date(from: decoded.results.civil_twilight_end)
                        
                        if let sunrise = self.sunrise {
                            self.goldenHourMorningEnd = Calendar.current.date(byAdding: .minute, value: 60, to: sunrise)
                            self.sunriseString = displayFormatter
                                .string(from: sunrise)
                            
                        }
                        if let sunset = self.sunset {
                            self.goldenHourEveningStart = Calendar.current.date(byAdding: .minute, value: -60, to: sunset)
                            self.sunsetString = displayFormatter
                                .string(from: sunset)
                        }
                        if let dawn = self.dawn {
                            self.dawnString = displayFormatter
                                .string(from: dawn)
                        }
                        if let twilight = self.twilight {
                            self.twilightString = displayFormatter
                                .string(from: twilight)
                        }
                        if let goldenEnd = self.goldenHourMorningEnd {
                            self.goldenHourMorningEndString = displayFormatter
                                .string(from: goldenEnd)
                        }
                        if let goldenStart = self.goldenHourEveningStart {
                            self.goldenHourEveningStartString = displayFormatter
                                .string(from: goldenStart)
                        }
                    }
                }
            } catch {
                print("Sun decoding error: \(error)")
            }
        }.resume()
    }
    
    func fetchPhasesAsync(latitude: Double, longitude: Double, date: Date = Date(), completion: @escaping (Date?) -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        
        guard let url = URL(string: "https://api.sunrise-sunset.org/json?lat=\(latitude)&lng=\(longitude)&formatted=0&date=\(dateString)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Sun API error: \(error?.localizedDescription ?? "unknown")")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(SunResponse.self, from: data)
                    
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
                
                DispatchQueue.main.async {
                    self.sunset = formatter.date(from: decoded.results.sunset)
                    
                    DispatchQueue.main.async {
                        completion(self.sunset)
                    }
                }
            } catch {
                print("Sun decoding error: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchSunset(for coordinate: CLLocationCoordinate2D, at date: Date) async -> Date? {
        await withCheckedContinuation { continuation in
            fetchPhasesAsync(latitude: coordinate.latitude, longitude: coordinate.longitude, date: date) { sunset in
                continuation.resume(returning: sunset)
            }
        }
    }
    
    private func fetchTimeZone(latitude: Double, longitude: Double, completion: @escaping (TimeZone?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let tz = placemarks?.first?.timeZone {
                completion(tz)
            } else {
                completion(nil)
            }
        }
    }
}
