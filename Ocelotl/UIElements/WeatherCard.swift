//
//  WeatherCard.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

public struct WeatherCard: View {
    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "cloud.sun")
                .font(.system(size: 24))
            Text("20°C")
                .font(Styleguide.bodyLarge())
            
            VStack(spacing: 8) {
                Text("24°C")
                    .font(Styleguide.bodySmall())
                    .foregroundColor(Styleguide.getBlueOpaque())
                Text("5°C")
                    .font(Styleguide.bodySmall())
                    .foregroundColor(Styleguide.getBlueOpaque())
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
