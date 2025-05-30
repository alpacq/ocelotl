//
//  PrecipCard.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

public struct PrecipCard: View {
    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "drop")
                .font(.system(size: 24))
            Text("0.5mm")
                .font(Styleguide.bodyLarge())
            
            VStack(spacing: 8) {
                Text("80%")
                    .font(Styleguide.bodySmall())
                    .foregroundColor(Styleguide.getBlueOpaque())
                Text("22mm")
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
