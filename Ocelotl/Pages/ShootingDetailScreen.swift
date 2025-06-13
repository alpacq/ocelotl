//
//  ShootingDetailScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 11/06/2025.
//

import SwiftUI
import SwiftData

struct ShootingDetailScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var shooting: Shooting
    
    @State private var selectedLocationEvent: ShootingEvent?
    @State private var selectedLocationShot: Shot?
    @State private var showLocationSheet = false
    
    @State private var isShootingPlanExpanded: Bool = true
    @State private var isShotListExpanded: Bool = true
    
    var body: some View {
        VStack(spacing: 24) {
            Header(
                title: $shooting.title,
                headerIcon: "film",
                actionIcons: ["video.badge.plus", "camera.aperture"],
                actionHandlers: [
                    { addShootingEvent() },
                    { addShot() }
                ]
            )
            
            ScrollView {
                VStack(spacing:24) {
                    
                    DisclosureGroup(
                        isExpanded: $isShootingPlanExpanded,
                        content: {
                            VStack(spacing: 12) {
                                ForEach($shooting.events) { event in
                                    if let binding = $shooting.events.first(where: { $0.id == event.id }) {
                                        ShootingEventRowView(event: binding, onLocationTap: {
                                            selectedLocationEvent = event.wrappedValue
                                        })
                                    }
                                }
                            }
                            .padding(.vertical, 24)
                        },
                        label: {
                            HStack(spacing: 8) {
                                Image(systemName: "video")
                                    .font(.system(size: 20))
                                Text("Shooting plan")
                                    .font(Styleguide.h6())
                            }
                        }
                    )
                    .font(Styleguide.h5())
                    .foregroundColor(Styleguide.getBlue())
                    
                    DisclosureGroup(
                        isExpanded: $isShotListExpanded,
                        content: {
                            VStack(spacing: 12) {
                                ForEach($shooting.shots) { shot in
                                    if let binding = $shooting.shots.first(where: { $0.id == shot.id }) {
                                        ShotRowView(shot: binding, onLocationTap: {
                                            selectedLocationShot = shot.wrappedValue
                                        })
                                    }
                                }
                            }
                            .padding(.vertical, 24)
                        },
                        label: {
                            HStack(spacing: 8) {
                                Image(systemName: "camera.aperture")
                                    .font(.system(size: 20))
                                Text("Shot list")
                                    .font(Styleguide.h6())
                            }
                        }
                    )
                    .foregroundColor(Styleguide.getBlue())
                    
                    Spacer()
                }
                .padding()
            }
        }
        .sheet(item: $selectedLocationEvent) { event in
            LocationSearchSheet(
                isPresented: $showLocationSheet,
                locationName: .constant(event.locationName)
            ) { coord, name in
                Task {
//                    await viewModel.updateLocation(for: event, coordinate: coord, name: name)
//                    await viewModel.updateSunsetEvents()
                }
                selectedLocationEvent = nil
            }
        }
        .sheet(item: $selectedLocationShot) { shot in
            LocationSearchSheet(
                isPresented: $showLocationSheet,
                locationName: .constant(shot.locationName)
            ) { coord, name in
                Task {
                    //                    await viewModel.updateLocation(for: event, coordinate: coord, name: name)
                    //                    await viewModel.updateSunsetEvents()
                }
                selectedLocationShot = nil
            }
        }
        .background(Styleguide.getAlmostWhite())
        .foregroundColor(Styleguide.getBlue())
    }
    
    private func addShootingEvent() {
        let event = ShootingEvent()
        event.shooting = shooting
        $shooting.wrappedValue.events.append(event)
        modelContext.insert(event)
    }
    
    private func addShot() {
        let shot = Shot()
        shot.shooting = shooting
        $shooting.wrappedValue.shots.append(shot)
        modelContext.insert(shot)
    }
}

#Preview {
    ShootingDetailScreen(
        shooting: Shooting(title: "Coffee documentary")
    )
    .modelContainer(
        for: [Shooting.self, Shot.self, ShootingEvent.self],
        inMemory: true
    )
}
