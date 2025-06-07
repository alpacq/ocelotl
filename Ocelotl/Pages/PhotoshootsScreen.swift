//
//  PhotoshootsScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import SwiftUI
import SwiftData

public struct PhotoshootsScreen: View {
    @Query(sort: \Photoshoot.date, order: .forward) var shoots: [Photoshoot]
    @Environment(\.modelContext) private var modelContext
    
    @State private var showAddSheet = false
    @State private var headerTitle = "My photoshoots"
    
    @State private var selectedPhotoshoot: Photoshoot?
    @State private var isShowingDetail = false
    
    @StateObject private var sunFetcher = SunFetcher()
    @StateObject private var weatherFetcher = WeatherFetcher()
    @StateObject private var locationManager = LocationManager()
    
    public var body: some View {
        VStack(spacing: 32) {
            Header(title: $headerTitle,
                   headerIcon: "camera",
                   actionIcons: ["plus.app"],
                   actionHandlers: [showSheet])
            
            VStack(spacing: 0) {
                TableHeaderView(leadingIcon: "calendar", trailingIcon: "camera")
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(
                            Array(shoots.enumerated()),
                            id: \.1.id
                        ) { index, shoot in
                            EventRowView(
                                item: shoot,
                                isEven: index.isMultiple(of: 2),
                                onDelete: { modelContext.delete(shoot) }
                            )
                            .onTapGesture {
                                selectedPhotoshoot = shoot
                                isShowingDetail = true
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddPhotoshootSheet { title, date in
                modelContext.insert(Photoshoot(title: title, date: date))
                try? modelContext.save()
            }
        }
        .background(Styleguide.getAlmostWhite())
        .navigationDestination(isPresented: $isShowingDetail) {
            if let selected = selectedPhotoshoot {
                PhotoshootDetailScreen(
                    photoshoot: selected
                )
//                .onDisappear {
//                    viewModel.update(selected)
//                }
            }
        }
    }
    
    private func showSheet() {
        showAddSheet = true
    }
}

#Preview {
    PhotoshootsScreen()
        .modelContainer(for: [Photoshoot.self, Shooting.self, PhotoshootEvent.self], inMemory: false) // <- persistuje
}
