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
                   actionIcon: "plus.app",
                   action: showSheet)
            
            VStack(spacing: 0) {
                TableHeaderView()
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(viewModel.shoots.enumerated()), id: \.1.id) { index, shoot in
                            PhotoshootRow(
                                shoot: shoot,
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
