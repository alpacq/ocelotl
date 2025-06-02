//
//  ContentView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 15/04/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var tabSelection: String = "home"
    @State private var showSplash = true  // <-- Dodajemy flagę pokazywania splash
    
    var body: some View {
        Group {
            if showSplash {
                SplashScreen()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                NavigationStack {
                    TabView(selection: $tabSelection) {
                        HomeScreen()
                            .tag("home")
                        
                        PhotoshootsScreen()
                            .tag("photo")
                        
                        ShootingsScreen()
                            .tag("film")
                        
                        ProfileScreen()
                            .tag("user")
                        
                        Text("More")
                            .font(Styleguide.body())
                            .foregroundColor(Styleguide.getBlue())
                            .tag("more")
                    }
                    .safeAreaInset(edge: .bottom) {
                        HStack {
                            Image(systemName: "thermometer.sun")
                                .font(.system(size: 28))
                                .foregroundColor(tabSelection == "home" ? Styleguide.getOrange() : Styleguide.getOrangeOpaque())
                                .onTapGesture { tabSelection = "home" }
                            Spacer()
                            
                            Image(systemName: "camera")
                                .font(.system(size: 28))
                                .foregroundColor(tabSelection == "photo" ? Styleguide.getOrange() : Styleguide.getOrangeOpaque())
                                .onTapGesture { tabSelection = "photo" }
                            Spacer()
                            
                            Image(systemName: "movieclapper")
                                .font(.system(size: 28))
                                .foregroundColor(tabSelection == "film" ? Styleguide.getOrange() : Styleguide.getOrangeOpaque())
                                .onTapGesture { tabSelection = "film" }
                            Spacer()
                            
                            Image(systemName: "gearshape")
                                .font(.system(size: 28))
                                .foregroundColor(tabSelection == "user" ? Styleguide.getOrange() : Styleguide.getOrangeOpaque())
                                .onTapGesture { tabSelection = "user" }
                            Spacer()
                            
                            Image(systemName: "ellipsis")
                                .font(.system(size: 28))
                                .foregroundColor(tabSelection == "more" ? Styleguide.getOrange() : Styleguide.getOrangeOpaque())
                                .onTapGesture { tabSelection = "more" }
                        }
                        .padding(.top, 24)
                        .padding(.bottom, 24)
                        .padding([.leading, .trailing], 16)
                        .frame(maxWidth: .infinity)
                        .background(Styleguide.getAlmostWhite())
                        .overlay(Rectangle().frame(height: 1).foregroundColor(Styleguide.getBlue()), alignment: .top)
                    }
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: showSplash)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
