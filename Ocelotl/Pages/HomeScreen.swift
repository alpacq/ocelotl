//
//  HomeScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import SwiftUI
import CoreLocation

public struct HomeScreen: View {
    @StateObject private var weatherFetcher = WeatherFetcher()
    @StateObject private var sunFetcher = SunFetcher() // AstronomyAPI-based
    @StateObject private var kpFetcher = KpFetcher()
    @StateObject private var locationManager = LocationManager()
    
    @State private var locationName = ""
    @State private var showLocationSheet = false
    @State private var hasManuallySelectedLocation = false
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    @State private var isDropdownExpanded = false
    @State private var selectedDrone = "DJI Mini 3"
    private let droneOptions = ["DJI Mini 3", "DJI Mini 3 Pro", "DJI Mini 4 Pro"]
    
    public var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                VStack(spacing: 24) {
                    Header(title: $locationName,
                           headerIcon: "globe.europe.africa",
                           actionIcon: "location",
                           action: promptForLocation)
                    
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
                            
                            Dropdown(isExpanded: $isDropdownExpanded, selectedOption: $selectedDrone, options: droneOptions)
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
                }
                if isDropdownExpanded {
                    VStack(spacing: 0) {
                        ForEach(droneOptions, id: \.self) { option in
                            Text(option)
                                .font(Styleguide.body())
                                .padding(8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Styleguide.getAlmostWhite())
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedDrone = option
                                        isDropdownExpanded = false
                                    }
                                }
                        }
                    }
                    .background(Styleguide.getAlmostWhite())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Styleguide.getOrange(), lineWidth: 1)
                    )
                    .frame(maxWidth: 264)
                    .offset(x: 110, y: 170) // <-- dostosuj pozycję zależnie od layoutu
                    .zIndex(100)
                }
            }
        }
        
        .sheet(isPresented: $showLocationSheet) {
            LocationSearchSheet(
                isPresented: $showLocationSheet,
                locationName: $locationName
            ) { coord, name in
                locationName = name
                selectedCoordinate = coord
                hasManuallySelectedLocation = true
                weatherFetcher.fetchWeather(latitude: coord.latitude, longitude: coord.longitude)
                sunFetcher.fetchPhases(latitude: coord.latitude, longitude: coord.longitude)
            }
        }
        .onReceive(locationManager.$currentLocation.compactMap { $0 }.removeDuplicates(by: { $0.latitude == $1.latitude && $0.longitude == $1.longitude })) { coord in
            guard !hasManuallySelectedLocation else { return }
            
            weatherFetcher.fetchWeather(latitude: coord.latitude, longitude: coord.longitude)
            sunFetcher.fetchPhases(latitude: coord.latitude, longitude: coord.longitude)
            kpFetcher.fetchKpIndex()
            
            let geocoder = LocationIQGeocoder()
            geocoder.reverse(lat: coord.latitude, lon: coord.longitude) { name in
                DispatchQueue.main.async {
                    locationName = name?.components(separatedBy: ",").first ?? "My Location"
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Styleguide.getAlmostWhite())
        .foregroundColor(Styleguide.getBlue())
    }
    
    private func promptForLocation() {
        showLocationSheet = true
    }
}
