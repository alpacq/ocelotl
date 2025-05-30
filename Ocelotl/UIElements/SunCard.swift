//
//  SunCard.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

public struct SunCard: View {
    public var body: some View {
        VStack(spacing: 24) {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "sunrise")
                    .font(.system(size: 24))
                
                VStack(spacing: 8) {
                    HStack {
                        Text("Dawn")
                            .font(Styleguide.bodySmall())
                        Spacer()
                        Text("5:54")
                            .font(Styleguide.bodySmall())
                    }
                    
                    HStack {
                        Text("Sunrise")
                            .font(Styleguide.bodySmall())
                        Spacer()
                        Text("6:36")
                            .font(Styleguide.bodySmall())
                    }
                    
                    HStack {
                        Text("Golden hour end")
                            .font(Styleguide.bodySmall())
                        Spacer()
                        Text("7:12")
                            .font(Styleguide.bodySmall())
                    }
                }
            }
            
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "sunset")
                    .font(.system(size: 24))
                
                VStack(spacing: 8) {
                    HStack {
                        Text("Golden hour start")
                            .font(Styleguide.bodySmall())
                        Spacer()
                        Text("18:22")
                            .font(Styleguide.bodySmall())
                    }
                    
                    HStack {
                        Text("Sunset")
                            .font(Styleguide.bodySmall())
                        Spacer()
                        Text("19:15")
                            .font(Styleguide.bodySmall())
                    }
                    
                    HStack {
                        Text("Twilight")
                            .font(Styleguide.bodySmall())
                        Spacer()
                        Text("20:04")
                            .font(Styleguide.bodySmall())
                    }
                }
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
