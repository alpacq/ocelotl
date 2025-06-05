//
//  Profile.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import SwiftUI
import Combine

struct ProfileScreen: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            Header(
                title: .constant(viewModel.headerTitle),
                headerIcon: "gearshape",
                actionIcons: nil,
                actionHandlers: nil
            )
            
            Text("Use this page to update your gear, so you can get personalized weather summaries and warnings.")
                .font(Styleguide.body())
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)
            
            HStack(spacing: 16) {
                Text("Your name is")
                    .font(Styleguide.body())
                TextField("Enter your name", text: $viewModel.nameInput)
                    .font(Styleguide.body())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .background(Styleguide.getAlmostWhite())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Styleguide.getOrange(), lineWidth: 1)
                    )
            }
            .padding(.horizontal, 16)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Your drone is")
                    .font(Styleguide.body())
                    .padding(.horizontal, 16)
                
                DronePickerView(selectedDrone: $viewModel.selectedDrone)
            }
            .padding(.trailing, 16)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Styleguide.getAlmostWhite())
        .foregroundColor(Styleguide.getBlue())
    }
}
