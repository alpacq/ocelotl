//
//  Photoshoot.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 03/06/2025.
//

import Foundation

struct Photoshoot: Identifiable, Codable, Equatable {
    var id: UUID
    var date: Date
    var title: String
    
    init(id: UUID = UUID(), date: Date, title: String) {
        self.id = id
        self.date = date
        self.title = title
    }
}
