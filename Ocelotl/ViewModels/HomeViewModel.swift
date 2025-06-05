//
//  HomeViewModel.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 04/06/2025.
//

import SwiftUI
import CoreLocation
import Combine

class HomeViewModel: ObservableObject {
    @AppStorage("selectedDroneName") var selectedDroneName: String = ""
    @AppStorage("userName") var userName: String = ""
    
    @Published var locationName: String = "My Location"
    @Published var selectedCoordinate: CLLocationCoordinate2D?
    @Published var hasManuallySelectedLocation = false
    @Published var showLocationSheet = false
    
    @Published var weatherFetcher = WeatherFetcher()
    @Published var sunFetcher = SunFetcher()
    @Published var kpFetcher = KpFetcher()
    @Published var weatherComment: String = "Loading weather comment..."
    
    private let commentService = WeatherCommentService()
    private var cancellables = Set<AnyCancellable>()
    private let locationManager = LocationManager()
    
    init() {
        observeLocationUpdates()
    }
    
    func promptForLocation() {
        showLocationSheet = true
    }
    
    func selectLocation(_ coord: CLLocationCoordinate2D, name: String) {
        locationName = name
        selectedCoordinate = coord
        hasManuallySelectedLocation = true
        
        weatherFetcher.fetchWeather(latitude: coord.latitude, longitude: coord.longitude) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.generateWeatherComment()
            }
        }
        sunFetcher.fetchPhases(latitude: coord.latitude, longitude: coord.longitude)
        kpFetcher.fetchKpIndex()
    }
    
    private func observeLocationUpdates() {
        locationManager.$currentLocation
            .compactMap { $0 }
            .removeDuplicates(by: { $0.latitude == $1.latitude && $0.longitude == $1.longitude })
            .sink { [weak self] coord in
                guard let self = self else { return }
                guard !self.hasManuallySelectedLocation else { return }
                
                self.selectedCoordinate = coord
                self.weatherFetcher.fetchWeather(latitude: coord.latitude, longitude: coord.longitude) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.generateWeatherComment()
                    }
                }
                self.sunFetcher.fetchPhases(latitude: coord.latitude, longitude: coord.longitude)
                self.kpFetcher.fetchKpIndex()
                
                let geocoder = LocationIQGeocoder()
                geocoder.reverse(lat: coord.latitude, lon: coord.longitude) { name in
                    DispatchQueue.main.async {
                        self.locationName = name?.components(separatedBy: ",").first ?? "My Location"
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func generateWeatherComment() {
        commentService.generateComment(
            droneName: selectedDroneName,
            windSpeed: weatherFetcher.currentWindSpeed ?? 0.0,
            windGust: weatherFetcher.currentWindGust ?? 0.0,
            precipitation: weatherFetcher.currentPrecipitation ?? 0.0,
            weatherSymbol: weatherFetcher.currentWeatherSymbol ?? "unknown"
        ) { [weak self] comment in
            DispatchQueue.main.async {
                self?.weatherComment = comment ?? "Could not generate comment."
            }
        }
    }
}
