//
//  LocationManager.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 02/06/2025.
//

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private let geocoder = LocationIQGeocoder()
    
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var resolvedName: String?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.first else { return }
        currentLocation = loc.coordinate
        
        geocoder.reverse(lat: loc.coordinate.latitude, lon: loc.coordinate.longitude) { name in
            DispatchQueue.main.async {
                if let name = name {
                    self.resolvedName = name
                }
            }
        }
        
        manager.stopUpdatingLocation()
    }
}
