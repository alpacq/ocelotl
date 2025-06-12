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
            
            VStack(spacing:24) {
                
                DisclosureGroup("Shooting plan", isExpanded: $isShootingPlanExpanded) {
                    VStack(spacing: 12) {
                        ForEach($shooting.events) { event in
                            if let binding = $shooting.events.first(where: { $0.id == event.id }) {
                                ShootingEventRowView(event: binding)
                            }
                        }
                    }
                }
                .font(Styleguide.h5())
                .foregroundColor(Styleguide.getBlue())
                
                DisclosureGroup("Shots list", isExpanded: $isShotListExpanded) {
                    VStack(spacing: 12) {
                        ForEach($shooting.shots) { shot in
                            if let binding = $shooting.shots.first(where: { $0.id == shot.id }) {
                                ShotRowView(shot: binding)
                            }
                        }
                    }
                }
                .font(Styleguide.h5())
                .foregroundColor(Styleguide.getBlue())
                
                Spacer()
            }
            .padding()
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
