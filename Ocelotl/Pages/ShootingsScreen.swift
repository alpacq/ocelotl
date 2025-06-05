//
//  ShootingsScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import SwiftUI

struct ShootingsScreen: View {
    @StateObject private var viewModel = ShootingsViewModel()
    @State private var showAddSheet = false
    @State private var headerTitle = "My shootings"
    
    var body: some View {
        VStack(spacing: 32) {
            Header(title: $headerTitle,
                   headerIcon: "movieclapper",
                   actionIcons: ["plus.app"],
                   actionHandlers: [showSheet])
            
            VStack(spacing: 0) {
                TableHeaderView(leadingIcon: "calendar", trailingIcon: "film")
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(
                            Array(viewModel.sortedShootings.enumerated()),
                            id: \.1.id
                        ) { index, shooting in
                            EventRowView(item: shooting,
                                         isEven: index.isMultiple(of: 2),
                                         onDelete: { viewModel.remove(shooting) })
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddShootingSheet { title, date in
                viewModel.addShooting(title: title, date: date)
            }
        }
        .background(Styleguide.getAlmostWhite())
    }
    
    private func showSheet() {
        showAddSheet = true
    }
}

#Preview {
    ShootingsScreen()
}
