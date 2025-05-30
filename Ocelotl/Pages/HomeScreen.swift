//
//  HomeScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import SwiftUI

public struct HomeScreen: View {
    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Header()
                
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("May 30th, 2025")
                            .font(Styleguide.h6())
                            .foregroundColor(Styleguide.getOrange())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    HStack(alignment: .top, spacing: 16) {
                        Text("You're flying")
                            .font(Styleguide.body())
                            .padding([.top, .bottom], 8)
                        
                        Dropdown()
                    }
                    
                    Text("Weather is good for flying your Mini 3, but be aware of wind gusts that may happen from time to time.")
                        .font(Styleguide.body())
                    
                    HStack(alignment: .top, spacing: 24) {
                        VStack(alignment: .leading, spacing: 24) {
                            WeatherCard()
                            WindCard()
                            PrecipCard()
                        }
                        
                        VStack(alignment: .trailing, spacing: 24) {
                            SunCard()
                            KpCard()
                        }
                    }
                }
                .padding([.leading, .trailing], 16)
                
                WeekWeatherStack()
                    .padding(.bottom, 24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Styleguide.getAlmostWhite())
        .foregroundColor(Styleguide.getBlue())
    }
}
