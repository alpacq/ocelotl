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
    
    @StateObject private var weatherFetcher = WeatherFetcher()
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel: ShootingDetailViewModel
    
    @State private var selectedLocationEvent: ShootingEvent?
    @State private var selectedLocationShot: Shot?
    @State private var showLocationSheet = false
    
    @State private var isShootingPlanExpanded: Bool = true
    @State private var isShotListExpanded: Bool = true
    
    init(shooting: Shooting) {
        _viewModel = StateObject(wrappedValue: ShootingDetailViewModel(
            shooting: shooting,
            weatherFetcher: WeatherFetcher(),
            locationManager: LocationManager()
        ))
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Header(
                title: $viewModel.shooting.title,
                headerIcon: "film",
                actionIcons: ["video.badge.plus", "camera.aperture"],
                actionHandlers: [
                    { viewModel.addEvent() },
                    { viewModel.addShot() }
                ]
            )
            
            List {
                if isShootingPlanExpanded {
                    Section(header: sectionHeader(title: "Shooting plan", icon: "video", isExpanded: $isShootingPlanExpanded)) {
                        let sorted = viewModel.shooting.events
                            .enumerated()
                            .sorted { ($0.element.time ?? .distantPast) < ($1.element.time ?? .distantPast) }
                        
                        ForEach(sorted, id: \.element.id) { index, _ in
                            rowView(for: $viewModel.shooting.events[index])
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        viewModel.deleteEvent(viewModel.shooting.events[index])
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .listRowBackground(Styleguide.getAlmostWhite())
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                        }
                    }
                }
                
                if isShotListExpanded {
                    Section(header: sectionHeader(title: "Shot list", icon: "camera.aperture", isExpanded: $isShotListExpanded)) {
                        let sorted = viewModel.shooting.shots
                            .enumerated()
                            .sorted { $0.element.scene < $1.element.scene }
                        
                        ForEach(sorted, id: \.element.id) { index, _ in
                            shotView(for: $viewModel.shooting.shots[index])
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        viewModel.deleteShot(viewModel.shooting.shots[index])
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .listRowBackground(Styleguide.getAlmostWhite())
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Styleguide.getAlmostWhite())
        }
        .onAppear {
            viewModel.modelContext = modelContext
        }
        .sheet(item: $selectedLocationEvent) { event in
            LocationSearchSheet(
                isPresented: $showLocationSheet,
                locationName: .constant(event.locationName)
            ) { coord, name in
                Task {
                    await viewModel.updateLocation(for: event, coordinate: coord, name: name)
                }
                selectedLocationEvent = nil
            }
        }
        .background(Styleguide.getAlmostWhite())
        .foregroundColor(Styleguide.getBlue())
    }
    
    @ViewBuilder
    private func rowView(for event: Binding<ShootingEvent>) -> some View {
        let weather = viewModel.eventWeather[event.wrappedValue.id]
        
        ShootingEventRowView(
            event: event,
            onLocationTap: {
                selectedLocationEvent = event.wrappedValue
            },
            weather: weather
        )
        .id(event.wrappedValue.id.uuidString + (weather?.symbolName ?? "-"))
        .onChange(of: event.wrappedValue.time) { _, _ in
            Task {
                await viewModel.fetchForecast(for: event.wrappedValue)
            }
        }
        .onChange(of: event.wrappedValue.coordinate) { _, _ in
            Task {
                await viewModel.fetchForecast(for: event.wrappedValue)
            }
        }
        .onChange(of: event.wrappedValue.eventDescription) { _, _ in
            viewModel.updateSceneOptions()
        }
    }
    
    @ViewBuilder
    private func shotView(for shot: Binding<Shot>) -> some View {
        ShotRowView(
            shot: shot,
            sceneOptions: viewModel.sceneOptions)
    }
    
    @ViewBuilder
    private func sectionHeader(title: String, icon: String, isExpanded: Binding<Bool>) -> some View {
        Button(action: {
            isExpanded.wrappedValue.toggle()
        }) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(title)
                    .font(Styleguide.h6())
                Spacer()
                Image(systemName: isExpanded.wrappedValue ? "chevron.down" : "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(Styleguide.getBlue())
            }
            .foregroundColor(Styleguide.getBlue())
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .contentShape(Rectangle())
            .background(Styleguide.getAlmostWhite())
        }
        .background(Styleguide.getAlmostWhite())
        .listRowInsets(EdgeInsets())
    }
    
}

#Preview {
    ShootingDetailScreen(
        shooting: Shooting(title: "Coffee documentary")
    )
    .modelContainer(
        for: [Shooting.self, Shot.self, ShootingEvent.self],
        inMemory: false
    )
}
