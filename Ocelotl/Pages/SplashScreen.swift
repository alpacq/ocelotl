//
//  SplashScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 02/06/2025.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack(spacing: 32) {
            Image("jaguar") // Twoje logo w assets
                .resizable()
                .scaledToFit()
                .frame(width: 192, height: 192)
            
            Text("Ocelotl")
                .font(Styleguide.h4())
            
            Text("Your visual arts buddy")
                .font(Styleguide.body())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(Styleguide.getBlue())
        .background(Styleguide.getAlmostWhite())
    }
}
