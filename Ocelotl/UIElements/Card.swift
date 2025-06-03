//
//  Card.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

struct Card: View {
    let drone: Drone
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(drone.name)
                .font(Styleguide.body())
                .foregroundColor(Styleguide.getBlue())
                .padding([.top, .leading], 8)
            
            Image(drone.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 144, maxHeight: 181)
                .clipped()
        }
        .background(isSelected ? Styleguide.getBlueTotallyOpaque() : Styleguide.getAlmostWhite())
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Styleguide.getOrange(), lineWidth: 1)
        )
        .onTapGesture(perform: onTap)
    }
}
