//
//  DayWeatherStack.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 25/05/2025.
//

import SwiftUI

struct DayWeatherStack: View {
    let date: Date
    let icon: String
    let temperature: Double
    let precipitation: Double
    let windSpeed: Double
    
    var body: some View {
        VStack(spacing: 24) {
            VStack {
                Text(date.formatted(.dateTime.weekday(.abbreviated)))
                    .font(Styleguide.bodySmall())
                
                Text(Calendar.current.component(.day, from: date).ordinalString)
                    .font(Styleguide.bodySmall())
            }
            
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text("\(Int(temperature))°C")
                    .font(Styleguide.body())
                
                HStack(spacing: 4) {
                    if precipitation > 0.0 {
                        Image(systemName: "drop")
                            .font(.system(size: 12))
                    }
                    
                    if windSpeed >= 4.0 {
                        Image(systemName: "wind")
                            .font(.system(size: 12))
                    }
                }
                
                if precipitation > 0.0 {
                    Text("\(precipitation, specifier: "%.1f")mm")
                        .font(Styleguide.bodySmall())
                }
            }
        }
    }
}
