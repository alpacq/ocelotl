//
//  PhotoshootDetailViewModel.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 05/06/2025.
//

import Foundation
import SwiftData
import CoreLocation

class PhotoshootDetailViewModel: ObservableObject {
    // MARK: - Dependencies
    var modelContext: ModelContext!
    @Published var photoshoot: Photoshoot
    private let sunFetcher: SunFetcher
    private let weatherFetcher: WeatherFetcher
    private let locationManager: LocationManager
    
    // MARK: - State
    @Published var sunsetEventIDs: Set<UUID> = []
    @Published var eventWeather: [UUID: PhotoshootEventWeatherData] = [:]
    
    // MARK: - Init
    init(
        photoshoot: Photoshoot,
        sunFetcher: SunFetcher,
        weatherFetcher: WeatherFetcher,
        locationManager: LocationManager
    ) {
        self.photoshoot = photoshoot
        self.sunFetcher = sunFetcher
        self.weatherFetcher = weatherFetcher
        self.locationManager = locationManager
    }
    
    // MARK: - Event Management
    func addEvent() {
        let newEvent = PhotoshootEvent()
        newEvent.photoshoot = photoshoot
        photoshoot.events.append(newEvent)
        modelContext?.insert(newEvent)
        try? modelContext?.save()
    }
    
    func updateAllTimes(newDate: Date) async {
        let calendar = Calendar.current
        let newDateComponents = calendar.dateComponents([.year, .month, .day], from: newDate)
        
        for event in photoshoot.events {
            guard let oldTime = event.time else { continue }
            let oldTimeComponents = calendar.dateComponents([.hour, .minute, .second], from: oldTime)
            var combined = newDateComponents
            combined.hour = oldTimeComponents.hour
            combined.minute = oldTimeComponents.minute
            combined.second = oldTimeComponents.second
            event.time = calendar.date(from: combined)
        }
        try? modelContext?.save()
        await updateSunsetEvents()
    }
    
    func updateLocation(for event: PhotoshootEvent, coordinate: CLLocationCoordinate2D, name: String) async {
        event.coordinate = Coordinate(from: coordinate)
        event.locationName = name
        try? modelContext?.save()
        await updateSunsetEvents()
        
        Task { await fetchForecast(for: event) }
    }
    
    func fetchForecast(for event: PhotoshootEvent) async {
        guard let time = event.time, let coordinate = event.coordinate?.asCLLocationCoordinate2D else { return }
        
        if let forecast = await weatherFetcher.forecastData(for: coordinate, at: time) {
            await MainActor.run {
                self.eventWeather[event.id] = forecast
            }
        }
    }
    
    func updateSunsetEvents() async {
        let newSunsetIDs = await withTaskGroup(of: UUID?.self) { group in
            for event in photoshoot.events {
                guard let time = event.time,
                      let coord = event.coordinate?.asCLLocationCoordinate2D else { continue }
                
                group.addTask {
                    if let sunset = await self.sunFetcher.fetchSunset(
                        for: coord,
                        at: time
                    ),
                       Calendar.current.isDate(time, equalTo: sunset, toGranularity: .hour) {
                        return event.id
                    }
                    return nil
                }
            }
            
            var ids = Set<UUID>()
            for await result in group {
                if let id = result {
                    ids.insert(id)
                }
            }
            return ids
        }
        
        await MainActor.run {
            self.sunsetEventIDs = newSunsetIDs
        }
    }
    
    func isSunsetEvent(id: UUID) -> Bool {
        return sunsetEventIDs.contains(id)
    }
}
