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
            
            ScrollView {
                VStack(spacing:24) {
                    
                    DisclosureGroup(
                        isExpanded: $isShootingPlanExpanded,
                        content: {
                            VStack(spacing: 12) {
                                let sorted = viewModel.shooting.events
                                    .enumerated()
                                    .sorted {
                                        let t0 = $0.element.time ?? Date.distantPast
                                        let t1 = $1.element.time ?? Date.distantPast
                                        return t0 < t1
                                    }
                                
                                ForEach(sorted, id: \.element.id) { index, _ in
                                    rowView(for: $viewModel.shooting.events[index])
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
                                ForEach($viewModel.shooting.shots) { shot in
                                    if let binding = $viewModel.shooting.shots.first(where: { $0.id == shot.id }) {
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
        .sheet(item: $selectedLocationShot) { shot in
            LocationSearchSheet(
                isPresented: $showLocationSheet,
                locationName: .constant(shot.locationName)
            ) { coord, name in
                Task {
                    //await viewModel.updateLocation(for: event, coordinate: coord, name: name)
                }
                selectedLocationShot = nil
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
