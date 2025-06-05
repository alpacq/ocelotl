//
//  OnboardingScreen.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 02/06/2025.
//

import SwiftUI

struct OnboardingScreen: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("userName") private var userName = ""
    @AppStorage("selectedDroneName") private var selectedDroneName = ""
    
    @State private var nameInput = ""
    @State private var selectedDrone: Drone?
    
    var body: some View {
        VStack(spacing: 32) {
            Header(title: .constant("Let's get started!"),
                   headerIcon: "point.bottomleft.forward.to.point.topright.scurvepath",
                   actionIcons: nil,
                   actionHandlers: nil)
            
            Text("First, please let us know your name and then specify what gear you are using, so you can get personalized weather summaries and warnings.")
                .font(Styleguide.body())
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)
            
            HStack(spacing: 16) {
                Text("Your name is")
                    .font(Styleguide.body())
                TextField("Enter your name", text: $nameInput)
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
                
                DronePickerView(selectedDrone: $selectedDrone)
            }
            .padding(.trailing, 16)
            
            Button(action: {
                guard !nameInput.isEmpty, let drone = selectedDrone else { return }
                userName = nameInput
                selectedDroneName = drone.name
                hasCompletedOnboarding = true
            }) {
                Text("Continue")
                    .font(Styleguide.body())
                    .fontWeight(.bold)
                    .padding(.horizontal, 24)
                    .padding()
                    .background(Styleguide.getAlmostWhite())
                    .foregroundColor(Styleguide.getBlue())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Styleguide.getOrange(), lineWidth: 1)
                    )
            }
            .padding(.top, 24)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Styleguide.getAlmostWhite())
        .foregroundColor(Styleguide.getBlue())
    }
}
