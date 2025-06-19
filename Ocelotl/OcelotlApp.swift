//
//  OcelotlApp.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 15/04/2025.
//

import SwiftUI
import SwiftData

@main
struct OcelotlApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("userName") private var userName = ""
    @AppStorage("selectedDroneName") private var selectedDroneName = ""
    
//    init(){
//        if let appDomain = Bundle.main.bundleIdentifier {
//            UserDefaults.standard.removePersistentDomain(forName: appDomain)
//        }
//    }
    
//    init() {
//        // Tymczasowy reset
//        hasCompletedOnboarding = false
//        userName = ""
//        selectedDroneName = ""
//    }
    
    let styleguide = Styleguide()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [Photoshoot.self, Shooting.self, PhotoshootEvent.self, Shot.self, ShootingEvent.self])
    }
}


