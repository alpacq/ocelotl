//
//  PhotoshootEvent.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 05/06/2025.
//

import Foundation
import CoreLocation

struct PhotoshootEvent: Identifiable, Codable, Equatable {
    let id: UUID
    var time: Date?
    var description: String
    var locationName: String
    var coordinate: Coordinate?
    var weatherSummary: String?
}
