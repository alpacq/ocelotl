//
//  HourWeatherStack.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

struct HourWeatherStack: View {
    var body: some View {
        VStack(spacing: 24) {
            VStack {
                Text("12:00")
                    .font(Styleguide.bodySmall())
        
            }
            VStack(spacing: 8) {
                Image(systemName: "cloud.sun")
                    .font(.system(size: 20))
                Text("24°C")
                    .font(Styleguide.body())
                HStack(spacing: 4) {
                    Image(systemName: "drop")
                        .font(.system(size: 12))
                    Image(systemName: "wind")
                        .font(.system(size: 12))
                }
                Text("0.1mm")
                    .font(Styleguide.bodySmall())
            }
        }
        .foregroundColor(Styleguide.getBlue())
    }
}
