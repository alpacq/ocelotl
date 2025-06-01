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
                        if let dawn = fetcher.dawn {
                            Text("\(dawn.formatted(date: .omitted, time: .shortened))")
                                .font(Styleguide.bodySmall())
                        } else {
                            Text("0:00")
                                .font(Styleguide.bodySmall())
                        }
                    }
                    
                    HStack {
                        Text("Sunrise")
                            .font(Styleguide.bodySmall())
                        Spacer()
                        if let sunrise = fetcher.sunrise {
                            Text("\(sunrise.formatted(date: .omitted, time: .shortened))")
                                .font(Styleguide.bodySmall())
                        } else {
                            Text("0:00")
                                .font(Styleguide.bodySmall())
                        }
                    }
                    
                    HStack {
                        Text("Golden hour end")
                            .font(Styleguide.bodySmall())
                        Spacer()
                        if let goldenHourEnd = fetcher.goldenHourMorningEnd {
                            Text("\(goldenHourEnd.formatted(date: .omitted, time: .shortened))")
                                .font(Styleguide.bodySmall())
                        } else {
                            Text("0:00")
                                .font(Styleguide.bodySmall())
                        }
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
                        if let goldenHourStart = fetcher.goldenHourEveningStart {
                            Text("\(goldenHourStart.formatted(date: .omitted, time: .shortened))")
                                .font(Styleguide.bodySmall())
                        } else {
                            Text("0:00")
                                .font(Styleguide.bodySmall())
                        }
                    }
                    
                    HStack {
                        Text("Sunset")
                            .font(Styleguide.bodySmall())
                        Spacer()
                        if let sunset = fetcher.sunset {
                            Text("\(sunset.formatted(date: .omitted, time: .shortened))")
                                .font(Styleguide.bodySmall())
                        } else {
                            Text("0:00")
                                .font(Styleguide.bodySmall())
                        }
                    }
                    
                    HStack {
                        Text("Twilight")
                            .font(Styleguide.bodySmall())
                        Spacer()
                        if let twilight = fetcher.twilight {
                            Text("\(twilight.formatted(date: .omitted, time: .shortened))")
                                .font(Styleguide.bodySmall())
                        } else {
                            Text("0:00")
                                .font(Styleguide.bodySmall())
                        }
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
