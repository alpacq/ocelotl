//
//  PhotoshootEvent.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 05/06/2025.
//

import Foundation
import SwiftData

@Model
class PhotoshootEvent {
    var id: UUID
    var time: Date?
    var eventDescription: String
    var locationName: String
    var coordinate: Coordinate?
    
    @Relationship(inverse: \Photoshoot.events) var photoshoot: Photoshoot?
    
    init(
        id: UUID = UUID(),
        time: Date? = Date(),
        eventDescription: String = "",
        locationName: String = "",
        coordinate: Coordinate? = nil
    ) {
        self.id = id
        self.time = time
        self.eventDescription = eventDescription
        self.locationName = locationName
        self.coordinate = coordinate
    }
}
