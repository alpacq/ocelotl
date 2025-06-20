//
//  ShootingDetailViewModel.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 19/06/2025.
//

import Foundation
import SwiftData
import CoreLocation
import SwiftUICore

class ShootingDetailViewModel: ObservableObject {
    // MARK: - Dependencies
    @Environment(\.modelContext) private var modelContext
    @Published var shooting: Shooting
    @Published var sceneOptions: [String] = []

    private let weatherFetcher: WeatherFetcher
    private let locationManager: LocationManager
    
    // MARK: - State
    @Published var eventWeather: [UUID: EventWeatherData] = [:]
    
    // MARK: - Init
    init(
        shooting: Shooting,
        weatherFetcher: WeatherFetcher,
        locationManager: LocationManager
    ) {
        self.shooting = shooting
        self.weatherFetcher = weatherFetcher
        self.locationManager = locationManager
    }
    
    // MARK: - Event Management
    func addEvent() {
        let event = ShootingEvent()
        event.shooting = shooting
        shooting.events.append(event)
        modelContext.insert(event)
        try? modelContext.save()
        updateSceneOptions()
    }
    
    func deleteEvent(_ event: ShootingEvent) {
        if let index = shooting.events.firstIndex(where: { $0.id == event.id }) {
            modelContext.delete(event)
            shooting.events.remove(at: index)
            updateSceneOptions()
            try? modelContext.save()
        }
    }
    
    func addShot() {
        let shot = Shot()
        shot.shooting = shooting
        shooting.shots.append(shot)
        modelContext.insert(shot)
        try? modelContext.save()
    }
    
    func deleteShot(_ shot: Shot) {
        if let index = shooting.shots.firstIndex(where: { $0.id == shot.id }) {
            modelContext.delete(shot)
            shooting.shots.remove(at: index)
            try? modelContext.save()
        }
    }
    
    func updateLocation(for event: ShootingEvent, coordinate: CLLocationCoordinate2D, name: String) async {
        event.coordinate = Coordinate(from: coordinate)
        event.locationName = name
        try? modelContext.save()
        await fetchForecast(for: event)
    }
    
    func fetchForecast(for event: ShootingEvent) async {
        guard
            let time = event.time,
            let coordinate = event.coordinate?.asCLLocationCoordinate2D
        else { return }
        
        let eventID = event.id
        
        if let forecast = await weatherFetcher.forecastData(for: coordinate, at: time) {
            await MainActor.run {
                self.eventWeather[eventID] = forecast
            }
        }
    }
    
    func updateSceneOptions() {
        sceneOptions = shooting.events
            .map { $0.eventDescription }
            .filter { !$0.isEmpty }
    }
}
