//
//  PhotoshootsScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import SwiftUI

public struct PhotoshootsScreen: View {
    @StateObject private var viewModel = PhotoshootsViewModel()
    @State private var showAddSheet = false
    @State private var headerTitle = "My photoshoots"
    
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
                            Array(viewModel.sortedShoots.enumerated()),
                            id: \.1.id
                        ) { index, shoot in
                            EventRowView(
                                item: shoot,
                                isEven: index.isMultiple(of: 2),
                                onDelete: { viewModel.remove(shoot) }
                            )
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddPhotoshootSheet { title, date in
                viewModel.addPhotoshoot(title: title, date: date)
            }
        }
        .background(Styleguide.getAlmostWhite())
    }
    
    private func showSheet() {
        showAddSheet = true
    }
}

#Preview {
    PhotoshootsScreen()
}
