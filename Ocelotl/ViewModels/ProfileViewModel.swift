//
//  ProfileViewModel.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 03/06/2025.
//

import Combine
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var nameInput: String = ""
    @Published var selectedDrone: Drone?
    
    var cancellables = Set<AnyCancellable>()
    
    var headerTitle: String {
        "Hello \(nameInput.isEmpty ? "there" : nameInput)!"
    }
    
    @AppStorage("userName") private var userName = ""
    @AppStorage("selectedDroneName") private var selectedDroneName = ""
    
    init() {
        // Ustawienie początkowych wartości
        nameInput = userName
        selectedDrone = availableDrones.first(where: { $0.name == selectedDroneName })
        
        // Debounce na nazwie
        $nameInput
            .removeDuplicates()
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { [weak self] newName in
                guard let self = self, !newName.isEmpty else { return }
                self.userName = newName
            }
            .store(in: &cancellables)
        
        // Debounce na dronie
        $selectedDrone
            .removeDuplicates { $0?.id == $1?.id }
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { [weak self] drone in
                guard let self = self, let drone = drone else { return }
                self.selectedDroneName = drone.name
            }
            .store(in: &cancellables)
    }
}
