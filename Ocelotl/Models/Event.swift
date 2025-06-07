//
//  Event.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 04/06/2025.
//

import Foundation

protocol Event: Identifiable {
    var title: String { get }
    var date: Date { get }
}
