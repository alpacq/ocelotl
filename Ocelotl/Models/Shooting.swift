//
//  Shooting.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 04/06/2025.
//

import Foundation

struct Shooting: Event {
    var id: UUID
    var date: Date
    var title: String
    
    init(id: UUID = UUID(), date: Date, title: String) {
        self.id = id
        self.date = date
        self.title = title
    }
}
