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
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: symbolName)
                    .font(.system(size: 22))
                HStack(spacing: 8) {
                    if rain > 0.0 {
                        Image(systemName: "drop")
                            .font(.system(size: 10))
                    }
                    if wind > 4.0 {
                        Image(systemName: "wind")
                            .font(.system(size: 10))
                    }
                }
            }
            VStack(spacing: 18) {
                Text("\(Int(temperature.rounded()))°C")
                    .font(Styleguide.bodySmall())
                if rain > 0.0 {
                    Text(String(format: "%.1fmm", rain))
                        .font(Styleguide.caption())
                } else {
                    Spacer()
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.trailing, 8)
        .padding(.vertical, 8)
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
