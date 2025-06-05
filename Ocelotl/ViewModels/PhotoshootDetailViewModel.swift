//
//  PhotoshootDetailViewModel.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 05/06/2025.
//

import Foundation
import CoreLocation
import Combine

@MainActor
class PhotoshootDetailViewModel: ObservableObject {
    @Published var photoshoot: Photoshoot
    @Published var selectedLocationRowID: UUID?
    @Published var userLocation: CLLocationCoordinate2D?
    @Published private(set) var sunsetEventIDs: Set<UUID> = []

    private var locationManager: LocationManager
    private var cancellables = Set<AnyCancellable>()
    
    private let sunFetcher: SunFetcher
    private let weatherFetcher: WeatherFetcher
    
    init(photoshoot: Photoshoot, sunFetcher: SunFetcher, weatherFetcher: WeatherFetcher, locationManager: LocationManager) {
        self.photoshoot = photoshoot
        self.sunFetcher = sunFetcher
        self.weatherFetcher = weatherFetcher
        self.locationManager = locationManager
        
        // nasłuch aktualnej lokalizacji
        self.userLocation = locationManager.currentLocation
        locationManager.$currentLocation
            .receive(on: RunLoop.main)
            .sink { [weak self] coord in
                self?.userLocation = coord
            }
            .store(in: &cancellables)
        
        locationManager.$currentLocation
            .compactMap { $0 }
            .removeDuplicates { $0.latitude == $1.latitude && $0.longitude == $1.longitude }
            .sink { [weak self] coord in
                self?.userLocation = coord
                self?.sunFetcher.fetchPhases(latitude: coord.latitude, longitude: coord.longitude)
            }
            .store(in: &cancellables)
    }
    
    func updateAllTimes(newDate: Date) {
        let calendar = Calendar.current
        let newDateComponents =  calendar.dateComponents([.year, .month, .day], from: newDate)
        for i in 0 ..< photoshoot.events.count {
            let oldDateComponents = calendar.dateComponents([
                .hour,
                .minute,
                .second
            ], from: photoshoot.events[i].time!)
            var combinedComponents = newDateComponents
            combinedComponents.hour = oldDateComponents.hour
            combinedComponents.minute = oldDateComponents.minute
            combinedComponents.second = oldDateComponents.second
            photoshoot.events[i].time = calendar.date(from: combinedComponents)
        }
    }
    
    func addEmptyEvent() {
        let new = PhotoshootEvent(
            id: UUID(),
            time: photoshoot.date,
            description: "",
            locationName: "",
            coordinate: nil,
            weatherSummary: nil
        )
        photoshoot.events.append(new)
    }
    
    func updateLocation(for id: UUID, coordinate: Coordinate, name: String) {
        guard let index = photoshoot.events.firstIndex(where: { $0.id == id }) else { return }
        photoshoot.events[index].coordinate = coordinate
        photoshoot.events[index].locationName = name
        fetchForecast(for: photoshoot.events[index])
        updateSunsetEvents()
    }
    
    func updateTime(for id: UUID, newTime: Date) {
        guard let index = photoshoot.events.firstIndex(where: { $0.id == id }) else { return }
        photoshoot.events[index].time = newTime
        fetchForecast(for: photoshoot.events[index])
        updateSunsetEvents()
    }
    
    func updateDescription(for id: UUID, text: String) {
        guard let index = photoshoot.events.firstIndex(where: { $0.id == id }) else { return }
        photoshoot.events[index].description = text
    }
    
    func fetchForecast(for event: PhotoshootEvent) {
        guard let time = event.time,
              let coord = event.coordinate?.asCLLocationCoordinate2D,
              let index = photoshoot.events.firstIndex(where: { $0.id == event.id }) else { return }
        
        weatherFetcher.fetchForecast(for: coord, at: time) { summary in
            DispatchQueue.main.async {
                self.photoshoot.events[index].weatherSummary = summary
            }
        }
    }
    
    func fetchSunset(for event: PhotoshootEvent) {
        guard let time = event.time,
              let coord = event.coordinate?.asCLLocationCoordinate2D else { return }
        
        sunFetcher.fetchSunset(for: coord, at: time)
    }
    
    func isEventAtSunset(_ event: PhotoshootEvent) async -> Bool {
        guard let eventTime = event.time,
              let coordinate = event.coordinate?.asCLLocationCoordinate2D else {
            return false
        }
        
        sunFetcher.fetchSunset(for: coordinate, at: eventTime)
        
        if let sunset = sunFetcher.sunset {
            let cal = Calendar.current
            print(cal.component(.hour, from: eventTime) == cal.component(.hour, from: sunset))
            return cal.component(.hour, from: eventTime) == cal.component(.hour, from: sunset)
        }
        return false
    }
    
    func updateSunsetEvents() {
        Task {
            var newSet = Set<UUID>()
            
            for event in photoshoot.events {
                if await isEventAtSunset(event) {
                    newSet.insert(event.id)
                }
            }
            
            DispatchQueue.main.async {
                self.sunsetEventIDs = newSet
            }
        }
    }
    
    func isSunsetEvent(id: UUID) -> Bool {
        sunsetEventIDs.contains(id)
    }

    
    func localDate(from utcDate: Date, in timeZone: TimeZone) -> Date {
        let seconds = TimeInterval(timeZone.secondsFromGMT(for: utcDate))
        return Date(timeInterval: seconds, since: utcDate)
    }
}
