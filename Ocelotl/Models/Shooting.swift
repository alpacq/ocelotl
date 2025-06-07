//
//  Shooting.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 04/06/2025.
//

import Foundation
import SwiftData

@Model
class Shooting: Event {
    var id: UUID
    var title: String
    var date: Date
    
    init(id: UUID = UUID(), title: String = "", date: Date = .now) {
        self.id = id
        self.title = title
        self.date = date
    }
}
