//
//  WindCard.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

public struct WindCard: View {
    public var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 24) {
                Image(systemName: "wind")
                    .font(.system(size: 24))
                Text("24 km/h")
                    .font(Styleguide.bodySmall())
                    .foregroundColor(Styleguide.getBlueOpaque())
            }
            
            HStack(spacing: 8) {
                Text("21 km/h")
                    .font(Styleguide.bodyLarge())
                Spacer()
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 8))
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
}
