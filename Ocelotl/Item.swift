//
//  Item.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 15/04/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
