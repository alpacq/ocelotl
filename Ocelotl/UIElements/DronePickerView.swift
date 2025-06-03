//
//  DronePickerView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 03/06/2025.
//

import SwiftUI

struct DronePickerView: View {
    @Binding var selectedDrone: Drone?
    
    @State private var expandedFamilies: Set<String>
    
    init(selectedDrone: Binding<Drone?>) {
        self._selectedDrone = selectedDrone
        if let selected = selectedDrone.wrappedValue {
            _expandedFamilies = State(initialValue: [selected.family])
        } else {
            _expandedFamilies = State(initialValue: [])
        }
    }
    
    private var groupedDrones: [String: [Drone]] {
        Dictionary(grouping: availableDrones) { $0.family }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(groupedDrones.keys.sorted(), id: \.self) { family in
                    DisclosureGroup(
                        isExpanded: Binding(
                            get: { expandedFamilies.contains(family) },
                            set: { isExpanded in
                                if isExpanded {
                                    expandedFamilies.insert(family)
                                } else {
                                    expandedFamilies.remove(family)
                                }
                            }
                        ),
                        content: {
                            VStack(spacing: 0) {
                                ForEach(Array(groupedDrones[family]!.enumerated()), id: \.element.id) { index, drone in
                                    VStack(spacing: 0) {
                                        HStack {
                                            Text(drone.name)
                                                .font(Styleguide.bodySmall())
                                                .foregroundColor(Styleguide.getBlue())
                                                .padding(.leading, 16)
                                            Spacer()
                                            if selectedDrone == drone {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(Styleguide.getOrange())
                                            }
                                        }
                                        .padding(.vertical, 16)
                                        .padding(.trailing, 16)
                                        .background(
                                            selectedDrone == drone
                                            ? Styleguide.getBlueTotallyOpaque()
                                            : Styleguide.getAlmostWhite()
                                        )
                                        .padding(.leading, 16)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            selectedDrone = drone
                                        }
                                        
                                        if index < groupedDrones[family]!.count - 1 {
                                            Divider()
                                                .background(Styleguide.getOrange())
                                                .padding(.leading, 16)
                                        }
                                    }
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Styleguide.getBlue(), lineWidth: 1)
//                            )
                        },
                        label: {
                            Text(family)
                                .font(Styleguide.body())
                                .foregroundColor(Styleguide.getBlue())
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Styleguide.getAlmostWhite())
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    )
                    .padding(.horizontal, 16)
                }
            }
            .padding(.top, 8)
        }
        .background(Styleguide.getAlmostWhite())
    }
}

