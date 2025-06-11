//
//  ShootingEvent.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 11/06/2025.
//

import Foundation
import SwiftData

@Model
class ShootingEvent {
    var id: UUID
    var time: Date?
    var locationName: String
    var coordinate: Coordinate?
    var eventDescription: String
    
    @Relationship(inverse: \Shooting.events) var shooting: Shooting?
    
    init(
        time: Date? = nil,
        locationName: String = "",
        coordinate: Coordinate? = nil,
        eventDescription: String = ""
    ) {
        self.id = UUID()
        self.time = time
        self.locationName = locationName
        self.coordinate = coordinate
        self.eventDescription = eventDescription
    }
}
