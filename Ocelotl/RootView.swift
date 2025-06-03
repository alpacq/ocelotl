//
//  RootView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 02/06/2025.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var isSplashActive = true
    
    var body: some View {
        Group {
            if isSplashActive {
                SplashScreen()
            } else {
                if hasCompletedOnboarding {
                    ContentView()
                } else {
                    OnboardingScreen()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    isSplashActive = false
                }
            }
        }
    }
}

#Preview {
    RootView()
}
