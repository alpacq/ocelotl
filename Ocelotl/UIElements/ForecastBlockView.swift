//
//  ForecastBlockView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 07/06/2025.
//

import SwiftUI

struct ForecastBlockView: View {
    let temperature: Double
    let rain: Double
    let wind: Double
    let symbolName: String // SF Symbol lub własny
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: symbolName)
                Text("\(Int(temperature.rounded()))°C")
                    .font(Styleguide.bodySmall())
            }
            HStack(spacing: 12) {
                HStack(spacing: 2) {
                    Image(systemName: "drop")
                    Text(String(format: "%.1fmm", rain))
                }
                HStack(spacing: 2) {
                    Image(systemName: "wind")
                    Text(String(format: "%.1fm/s", wind))
                }
            }
            .font(Styleguide.bodySmall())
        }
        .foregroundColor(Styleguide.getBlue())
    }
}

#Preview {
    ForecastBlockView(
        temperature: 24.0,
        rain: 2.5,
        wind: 1.0,
        symbolName: "cloud.drizzle"
    )
}
