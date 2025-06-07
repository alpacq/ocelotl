//
//  Photoshoot.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 03/06/2025.
//

import Foundation
import SwiftData

@Model
class Photoshoot: Event {
    var id: UUID
    var title: String
    var date: Date
    
    @Relationship var events: [PhotoshootEvent] = []
    
    init(id: UUID = UUID(), title: String = "", date: Date = .now) {
        self.id = id
        self.title = title
        self.date = date
    }
}
