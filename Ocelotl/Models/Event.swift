//
//  Event.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 04/06/2025.
//

import Foundation

protocol Event: Identifiable, Codable, Equatable {
    var id: UUID { get }
    var date: Date { get }
    var title: String { get }
}
