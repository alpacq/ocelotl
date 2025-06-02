//
//  LocationSearchSheer.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 02/06/2025.
//

import SwiftUI
import CoreLocation

struct LocationSearchSheet: View {
    @Binding var isPresented: Bool
    @Binding var locationName: String
    
    @State private var query = ""
    @State private var history: [String] = UserDefaults.standard.stringArray(forKey: "locationHistory") ?? []
    
    private let geocoder = LocationIQGeocoder()
    
    var onSelectLocation: (_ coordinate: CLLocationCoordinate2D, _ name: String) -> Void
    
    var body: some View {
        NavigationView {
            List {
                if !query.isEmpty {
                    Section("Suggestions") {
                        Button("Search '\(query)'") {
                            geocodeAndSelect(query)
                        }
                    }
                }
                
                if !history.isEmpty {
                    Section("Recent") {
                        ForEach(history, id: \ .self) { item in
                            Button(action: {
                                geocodeAndSelect(item)
                            }) {
                                Text(item)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Location")
            .searchable(text: $query)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
    
    private func geocodeAndSelect(_ input: String) {
        geocoder.geocode(input) { coord, name in
            DispatchQueue.main.async {
                defer { isPresented = false }
                
                guard let coord = coord else {
                    print("Geocode failed for: \(input)")
                    return
                }
                
                let cleanedName = name?.components(separatedBy: ",").first ?? input
                locationName = cleanedName
                updateHistory(with: cleanedName)
                onSelectLocation(coord, cleanedName)
            }
        }
    }
    
    private func updateHistory(with new: String) {
        var current = UserDefaults.standard.stringArray(forKey: "locationHistory") ?? []
        current.removeAll { $0 == new }
        current.insert(new, at: 0)
        UserDefaults.standard.setValue(Array(current.prefix(10)), forKey: "locationHistory")
        history = current
    }
}
