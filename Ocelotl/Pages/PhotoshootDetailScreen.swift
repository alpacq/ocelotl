//
//  PhotoshootDetailScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 05/06/2025.
//

import SwiftUI
import CoreLocation

struct PhotoshootDetailScreen: View {
    @StateObject private var viewModel: PhotoshootDetailViewModel
    
    @State private var selectedDate: Date = Date()
    @State private var showLocationSheet = false
    @State private var showDateSheet = false
    
    init(photoshoot: Photoshoot,
         sunFetcher: SunFetcher,
         weatherFetcher: WeatherFetcher,
         locationManager: LocationManager) {
        _viewModel = StateObject(wrappedValue: PhotoshootDetailViewModel(
            photoshoot: photoshoot,
            sunFetcher: sunFetcher,
            weatherFetcher: weatherFetcher,
            locationManager: locationManager
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
                    { viewModel.addEmptyEvent() }
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
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(Array(viewModel.photoshoot.events.enumerated()), id: \.element.id) { index, event in
                            PhotoshootDetailRowView(
                                event: event,
                                index: index,
                                onLocationTap: {
                                    viewModel.selectedLocationRowID = event.id
                                    showLocationSheet = true
                                },
                                onTimeChange: { newTime in
                                    viewModel.updateTime(for: event.id, newTime: newTime)
                                },
                                onDescriptionChange: { newDesc in
                                    viewModel.updateDescription(for: event.id, text: newDesc)
                                },
                                isSunsetEvent: viewModel.isSunsetEvent(id: event.id),
                            )
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showLocationSheet) {
            LocationSearchSheet(
                isPresented: $showLocationSheet,
                locationName: .constant(""),
                onSelectLocation: { coord, name in
                    if let rowId = viewModel.selectedLocationRowID {
                        viewModel.updateLocation(for: rowId, coordinate: Coordinate(from: coord), name: name)
                    }
                }
            )
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
                    .onChange(of: selectedDate, perform: {newDate in
                        viewModel.photoshoot.date = newDate
                        viewModel.updateAllTimes(newDate: newDate)
                        viewModel.updateSunsetEvents()
                    })
                
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
        .onAppear() {
            selectedDate = viewModel.photoshoot.date
        }
    }
}

#Preview {
    PhotoshootDetailScreen(photoshoot: Photoshoot(date: Date(), title: "Anne & Gilbert wedding"), sunFetcher: SunFetcher(), weatherFetcher: WeatherFetcher(), locationManager: LocationManager())
}
