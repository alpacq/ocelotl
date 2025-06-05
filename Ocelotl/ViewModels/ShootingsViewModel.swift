//
//  ShootingsViewModel.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 04/06/2025.
//

import SwiftUI

class ShootingsViewModel: ObservableObject {
    @Published var shootings: [Shooting] = []
    
    private let storageKey = "shootings"
    
    var sortedShootings: [Shooting] {
        shootings.sorted { $0.date < $1.date }
    }
    
    init() {
        load()
    }
    
    func addShooting(title: String, date: Date) {
        shootings.append(Shooting(id: UUID(), date: date, title: title))
        save()
    }
    
    func remove(_ shooting: Shooting) {
        shootings.removeAll { $0.id == shooting.id }
        save()
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(shootings) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    private func load() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Shooting].self, from: data) {
            shootings = decoded
        }
    }
}
