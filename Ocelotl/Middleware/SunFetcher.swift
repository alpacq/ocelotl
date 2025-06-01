//
//  SunFetcher.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 31/05/2025.
//

import Foundation

class SunFetcher: ObservableObject {
    @Published var sunrise: Date?
    @Published var sunset: Date?
    @Published var dawn: Date?
    @Published var twilight: Date?
    @Published var goldenHourMorningEnd: Date?
    @Published var goldenHourEveningStart: Date?
    
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
                          
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
                
                DispatchQueue.main.async {
                    self.sunrise = formatter.date(from: decoded.results.sunrise)
                    self.sunset = formatter.date(from: decoded.results.sunset)
                    self.dawn = formatter.date(from: decoded.results.civil_twilight_begin)
                    self.twilight = formatter.date(from: decoded.results.civil_twilight_end)
                    
                    if let sunrise = self.sunrise {
                        self.goldenHourMorningEnd = Calendar.current.date(byAdding: .minute, value: 60, to: sunrise)
                    }
                    if let sunset = self.sunset {
                        self.goldenHourEveningStart = Calendar.current.date(byAdding: .minute, value: -60, to: sunset)
                    }
                }
            } catch {
                print("Sun decoding error: \(error)")
            }
        }.resume()
    }
}
