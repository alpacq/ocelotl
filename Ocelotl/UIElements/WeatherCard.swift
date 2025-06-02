//
//  WeatherCard.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

public struct WeatherCard: View {
    @ObservedObject var fetcher: WeatherFetcher
    
    public var body: some View {
        HStack(spacing: 8) {
            if let symbolCode = fetcher.currentWeatherSymbol {
                let sfSymbolName = sfSymbol(for: symbolCode)
                Image(systemName: sfSymbolName)
                    .font(.system(size: 24))
            } else {
                Image(systemName: "questionmark")
                    .font(.system(size: 24))
            }
            if let temperature = fetcher.temperature {
                Text("\(temperature, specifier: "%.0f")°C")
                    .font(Styleguide.bodyLarge())
            }
            
            VStack(spacing: 8) {
                if let minTemperature = fetcher.minTemperature, let maxTemperature = fetcher.maxTemperature {
                    Text("\(maxTemperature, specifier: "%.0f")°C")
                        .font(Styleguide.bodySmall())
                        .foregroundColor(Styleguide.getBlueOpaque())
                    Text("\(minTemperature, specifier: "%.0f")°C")
                        .font(Styleguide.bodySmall())
                        .foregroundColor(Styleguide.getBlueOpaque())
                }
            }
        }
        .foregroundColor(Styleguide.getBlue())
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Styleguide.getOrange(), lineWidth: 1)
            
        )
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
        case let s where s.contains("sleet"):
            return "cloud.sleet" // ogólny symbol deszczu ze śniegiem
        case "lightsleet":
            return "cloud.sleet"
        case "lightsleetshowers_day":
            return "cloud.sun.sleet"
        case "lightsleetshowers_night":
            return "cloud.moon.sleet"
        case "rainshowers_night":
            return "cloud.moon.rain"
        case "heavyrainshowers_night":
            return "cloud.moon.sleet"
        default:
            print(yrSymbol)
            return "questionmark"
        }
    }
}
