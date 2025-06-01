//
//  HomeScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import SwiftUI

public struct HomeScreen: View {
    @StateObject private var weatherFetcher = WeatherFetcher()
    @StateObject private var sunFetcher = SunFetcher()
    @StateObject private var kpFetcher = KpFetcher()
    
    @State private var locationName = "Warsaw, MZ"
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Header(title: $locationName,
                       icon: "globe.europe.africa",
                       actionIcon: "location",
                       action: nil)
                
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text(Date().formattedWithOrdinal())
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
                    
                    HStack(alignment: .top, spacing: 8) {
                        VStack(alignment: .leading, spacing: 24) {
                            WeatherCard(fetcher: weatherFetcher)
                            WindCard(fetcher: weatherFetcher)
                            PrecipCard(fetcher: weatherFetcher)
                        }
                        
                        VStack(alignment: .trailing, spacing: 24) {
                            SunCard(fetcher: sunFetcher)
                            KpCard(fetcher: kpFetcher)
                        }
                    }
                }
                .padding([.leading, .trailing], 16)
                
                WeekWeatherStack(fetcher: weatherFetcher)
                    //.padding(.bottom, 48)
            }
        }
        .onAppear {
            weatherFetcher.fetchWeather(latitude: 52.19, longitude: 21.03)
            sunFetcher.fetchPhases(latitude: 52.19, longitude: 21.03)
            kpFetcher.fetchKpIndex()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Styleguide.getAlmostWhite())
        .foregroundColor(Styleguide.getBlue())
    }
}
