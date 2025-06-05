//
//  HomeScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import SwiftUI
import CoreLocation

struct HomeScreen: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Header(title: $viewModel.locationName,
                       headerIcon: "globe.europe.africa",
                       actionIcons: ["location"],
                       actionHandlers: [viewModel.promptForLocation])
                
                VStack(spacing: 24) {
                    Text(Date().formattedWithOrdinal())
                        .font(Styleguide.h6())
                        .foregroundColor(Styleguide.getOrange())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(viewModel.weatherComment)
                        .font(Styleguide.body())
                    
                    HStack(alignment: .top, spacing: 8) {
                        VStack(alignment: .leading, spacing: 24) {
                            WeatherCard(fetcher: viewModel.weatherFetcher)
                            WindCard(fetcher: viewModel.weatherFetcher)
                            PrecipCard(fetcher: viewModel.weatherFetcher)
                        }
                        
                        VStack(alignment: .trailing, spacing: 24) {
                            SunCard(fetcher: viewModel.sunFetcher)
                            KpCard(fetcher: viewModel.kpFetcher)
                        }
                    }
                }
                .padding(.horizontal, 16)
                
                WeekWeatherStack(fetcher: viewModel.weatherFetcher)
            }
        }
        .sheet(isPresented: $viewModel.showLocationSheet) {
            LocationSearchSheet(
                isPresented: $viewModel.showLocationSheet,
                locationName: $viewModel.locationName
            ) { coord, name in
                viewModel.selectLocation(coord, name: name)
            }
        }
        .background(Styleguide.getAlmostWhite())
        .foregroundColor(Styleguide.getBlue())
    }
}

#Preview {
    HomeScreen()
}
