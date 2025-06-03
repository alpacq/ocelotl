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
