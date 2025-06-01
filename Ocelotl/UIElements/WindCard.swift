//
//  WindCard.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

public struct WindCard: View {
    @ObservedObject var fetcher: WeatherFetcher
    
    public var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 24) {
                Image(systemName: "wind")
                    .font(.system(size: 24))

                if let windGust = fetcher.currentWindGust {
                    Text("\(windGust, specifier: "%.0f") km/h")
                        .font(Styleguide.bodySmall())
                        .foregroundColor(Styleguide.getBlueOpaque())
                } else {
                    Text("0 km/h")
                        .font(Styleguide.bodySmall())
                        .foregroundColor(Styleguide.getBlueOpaque())
                }
            }
            
            HStack(spacing: 8) {
                if let windSpeed = fetcher.currentWindSpeed {
                    Text("\(windSpeed, specifier: "%.1f") km/h")
                        .font(Styleguide.bodyLarge())
                } else {
                    Text("0 km/h")
                        .font(Styleguide.bodyLarge())
                }
                
                Spacer()
                
                if let windDirection = fetcher.windDirection {
                    Image(systemName: windDirectionSymbol(for: windDirection))
                        .font(.system(size: 8))
                } else {
                    Image(systemName: "aqi.low")
                        .font(.system(size: 8))
                }
            }
            .fixedSize(horizontal: true, vertical: false)
        }
        .foregroundColor(Styleguide.getBlue())
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Styleguide.getOrange(), lineWidth: 1)
        )
    }
    
    private func windDirectionSymbol(for degrees: Double) -> String {
        switch degrees {
        case 337.5...360, 0..<22.5:
            return "arrow.down"
        case 22.5..<67.5:
            return "arrow.down.left"
        case 67.5..<112.5:
            return "arrow.left"
        case 112.5..<157.5:
            return "arrow.up.left"
        case 157.5..<202.5:
            return "arrow.up"
        case 202.5..<247.5:
            return "arrow.up.right"
        case 247.5..<292.5:
            return "arrow.right"
        case 292.5..<337.5:
            return "arrow.down.right"
        default:
            return "questionmark"
        }
    }
}
