//
//  PrecipCard.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

public struct PrecipCard: View {
    @ObservedObject var fetcher: WeatherFetcher
    
    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "drop")
                .font(.system(size: 24))
            if let currentPrecipitation = fetcher.currentPrecipitation {
                Text("\(currentPrecipitation, specifier: "%.1f")mm")
                    .font(Styleguide.bodyLarge())
            } else {
                Text("0mm")
                    .font(Styleguide.bodyLarge())
            }
            
            VStack(spacing: 8) {
                if let humidity = fetcher.currentHumidity {
                    Text("\(humidity, specifier: "%.0f")%")
                        .font(Styleguide.bodySmall())
                        .foregroundColor(Styleguide.getBlueOpaque())
                } else {
                    Text("0%")
                        .font(Styleguide.bodySmall())
                        .foregroundColor(Styleguide.getBlueOpaque())
                }
                if let dailyPrecipitation = fetcher.dailyPrecipitation {
                    Text("\(dailyPrecipitation, specifier: "%.0f")mm")
                        .font(Styleguide.bodySmall())
                        .foregroundColor(Styleguide.getBlueOpaque())
                } else {
                    Text("0mm")
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
}
