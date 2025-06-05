//
//  ContentView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 15/04/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var tabSelection: String = "home"
    @State private var moreHeaderTitle = "More"
    
    var body: some View {
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
                
                VStack {
                    Header(
                        title: $moreHeaderTitle,
                        headerIcon: "ellipsis",
                        actionIcons: nil,
                        actionHandlers: nil
                    )
                    Spacer()
                }
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

#Preview {
    ContentView()
}
