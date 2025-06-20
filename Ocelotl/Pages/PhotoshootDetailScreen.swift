//
//  PhotoshootDetailScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 05/06/2025.
//

import SwiftUI
import SwiftData

struct PhotoshootDetailScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject private var sunFetcher = SunFetcher()
    @StateObject private var weatherFetcher = WeatherFetcher()
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel: PhotoshootDetailViewModel
    
    @State private var selectedDate: Date
    @State private var selectedLocationEvent: PhotoshootEvent?
    @State private var showLocationSheet = false
    @State private var showDateSheet = false
    
    init(photoshoot: Photoshoot) {
        _selectedDate = State(initialValue: photoshoot.date)
        _viewModel = StateObject(wrappedValue: PhotoshootDetailViewModel(
            photoshoot: photoshoot,
            sunFetcher: SunFetcher(),
            weatherFetcher: WeatherFetcher(),
            locationManager: LocationManager()
        ))
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Header(
                title: $viewModel.photoshoot.title,
                headerIcon: "camera",
                actionIcons: ["calendar", "plus.app"],
                actionHandlers: [
                    { showDateSheet = true },
                    { viewModel.addEvent() }
                ]
            )
            
            Text(viewModel.photoshoot.date.formattedWithOrdinal())
                .font(Styleguide.h6())
                .foregroundColor(Styleguide.getOrange())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            VStack(spacing: 0) {
                TableHeaderThreeColumnView()
                
                List {
                    let sorted = viewModel.photoshoot.events
                        .enumerated()
                        .sorted {
                            let t0 = $0.element.time ?? Date.distantPast
                            let t1 = $1.element.time ?? Date.distantPast
                            return t0 < t1
                        }
                    
                    ForEach(sorted, id: \.element.id) { index, _ in
                        rowView(for: index, event: $viewModel.photoshoot.events[index])
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.deleteEvent(viewModel.photoshoot.events[index])
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Styleguide.getAlmostWhite())

            }
        }
        .onAppear {
            viewModel.modelContext = modelContext
            Task {
                await viewModel.updateSunsetEvents()
            }
            selectedDate = viewModel.photoshoot.date
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
                Task {
                    await viewModel.updateSunsetEvents()
                }
            }
        }
        .sheet(item: $selectedLocationEvent) { event in
            LocationSearchSheet(
                isPresented: $showLocationSheet,
                locationName: .constant(event.locationName)
            ) { coord, name in
                Task {
                    await viewModel.updateLocation(for: event, coordinate: coord, name: name)
                    await viewModel.updateSunsetEvents()
                }
                selectedLocationEvent = nil
            }
        }
        .sheet(isPresented: $showDateSheet) {
            VStack {
                Text("Edit shoot date")
                    .font(Styleguide.h5())
                    .foregroundColor(Styleguide.getBlue())
                    .padding()
                
                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                    .foregroundColor(Styleguide.getBlue())
                    .onChange(of: selectedDate) { _, newDate in
                        viewModel.photoshoot.date = newDate
                        Task {
                            await viewModel.updateAllTimes(newDate: newDate)
                            await viewModel.updateSunsetEvents()
                            for event in viewModel.photoshoot.events {
                                await viewModel.fetchForecast(for: event)
                            }
                        }
                    }
                
                Button("Done") {
                    showDateSheet = false
                }
                .padding()
                .foregroundColor(Styleguide.getOrange())
            }
            .background(Styleguide.getAlmostWhite())
        }
        .background(Styleguide.getAlmostWhite())
        .foregroundColor(Styleguide.getBlue())
    }
    
    @ViewBuilder
    private func rowView(for index: Int, event: Binding<PhotoshootEvent>) -> some View {
        let isSunset = viewModel.isSunsetEvent(id: event.wrappedValue.id)
        let weather = viewModel.eventWeather[event.wrappedValue.id]

        
        PhotoshootDetailRowView(
            event: event,
            index: index,
            onLocationTap: {
                selectedLocationEvent = event.wrappedValue
            },
            isSunsetEvent: isSunset,
            weather: weather
        )
        .id(event.wrappedValue.id.uuidString + (weather?.symbolName ?? "-"))
        .onChange(of: event.wrappedValue.time) { _, _ in
            Task {
                await viewModel.updateSunsetEvents()
                await viewModel.fetchForecast(for: event.wrappedValue)
            }
        }
        .onChange(of: event.wrappedValue.coordinate) { _, _ in
            Task {
                await viewModel.updateSunsetEvents()
                await viewModel.fetchForecast(for: event.wrappedValue)
            }
        }
    }
}

#Preview {
    PhotoshootDetailScreen(
        photoshoot: Photoshoot(title: "Anne & Gilbert wedding", date: Date())
    )
        .modelContainer(
            for: [Photoshoot.self, Shooting.self, PhotoshootEvent.self],
            inMemory: false
        )
}
