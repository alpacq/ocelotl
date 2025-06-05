//
//  PhotoshootsViewModel.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 03/06/2025.
//

import SwiftUI

class PhotoshootsViewModel: ObservableObject {
    @Published var shoots: [Photoshoot] = []
    
    private let storageKey = "photoshoots"
    
    var sortedShoots: [Photoshoot] {
        shoots.sorted { $0.date < $1.date }
    }
    
    init() {
        load()
    }
    
    func addPhotoshoot(title: String, date: Date) {
        shoots.append(Photoshoot(date: date, title: title))
        save()
    }
    
    func remove(_ shoot: Photoshoot) {
        shoots.removeAll { $0.id == shoot.id }
        save()
    }
    
    func update(_ updated: Photoshoot) {
        guard let index = shoots.firstIndex(where: { $0.id == updated.id }) else { return }
        shoots[index] = updated
        save()
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(shoots) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    private func load() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Photoshoot].self, from: data) {
            shoots = decoded
        }
    }
}
