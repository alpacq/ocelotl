//
//  ShootingsScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import SwiftUI
import SwiftData

struct ShootingsScreen: View {
    @Query(sort: \Shooting.date, order: .forward) var shoots: [Shooting]
    @Environment(\.modelContext) private var modelContext
    
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
                            Array(shoots.enumerated()),
                            id: \.1.id
                        ) { index, shooting in
                            EventRowView(item: shooting,
                                         isEven: index.isMultiple(of: 2),
                                         onDelete: { modelContext.delete(shooting) })
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddShootingSheet { title, date in
                modelContext.insert(Shooting(title: title, date: date))
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
