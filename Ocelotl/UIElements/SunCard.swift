//
//  SunCard.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

public struct SunCard: View {
    @ObservedObject var fetcher: SunFetcher
    
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
                        
                        
                        Text("\(fetcher.dawnString)")
                            .font(Styleguide.bodySmall())
                    }
                    
                    HStack {
                        Text("Sunrise")
                            .font(Styleguide.bodySmall())
                        
                        Spacer()
                        
                        Text("\(fetcher.sunriseString)")
                            .font(Styleguide.bodySmall())
                    }
                    
                    HStack {
                        Text("Golden hour end")
                            .font(Styleguide.bodySmall())
                        
                        Spacer()
                        
                        Text("\(fetcher.goldenHourMorningEndString)")
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
                        
                        Text("\(fetcher.goldenHourEveningStartString)")
                            .font(Styleguide.bodySmall())
                    }
                    
                    HStack {
                        Text("Sunset")
                            .font(Styleguide.bodySmall())
                        
                        Spacer()
                        
                        Text("\(fetcher.sunsetString)")
                            .font(Styleguide.bodySmall())
                    }
                    
                    HStack {
                        Text("Twilight")
                            .font(Styleguide.bodySmall())
                        
                        Spacer()
                        
                        Text("\(fetcher.twilightString)")
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
