//
//  Coordinate.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 05/06/2025.
//

import SwiftUI
import CoreLocation

struct Coordinate: Codable, Equatable {
    var latitude: Double
    var longitude: Double
    
    var asCLLocationCoordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(from coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}
