//
//  ShotRowView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 11/06/2025.
//

import SwiftUI

struct ShotRowView: View {
    @Binding var shot: Shot
    var onLocationTap: () -> Void
    
    let fpsOptions = ["24 fps", "25 fps", "30 fps"]
    let framingOptions = ["close", "medium", "wide"]
    let sceneOptions = ["ujęcie w domu", "ujęcie na zewnątrz"]
    
    @State private var isFpsExpanded = false
    @State private var fpsSelection: String = ""
    
    @State private var isFramingExpanded = false
    @State private var framingSelection: String = ""
    
    @State private var isSceneExpanded = false
    @State private var sceneSelection: String = ""
    
    @State private var locationText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TextField("description", text: $shot.shotDescription)
                    .font(Styleguide.body())
                    .foregroundColor(Styleguide.getBlue())
                
                Toggle(isOn: $shot.isCompleted) {
                    EmptyView()
                }
                .labelsHidden()
            }
            
            HStack {
                VStack(spacing: 8) {
                    Dropdown(isExpanded: $isFpsExpanded, selectedOption: $fpsSelection, options: fpsOptions)
                    
                    Dropdown(isExpanded: $isSceneExpanded, selectedOption: $sceneSelection, options: sceneOptions)
                }
                
                VStack(spacing: 8) {
                    Dropdown(isExpanded: $isFramingExpanded, selectedOption: $framingSelection, options: framingOptions)
                    
                    HStack(spacing: 4) {
                        TextField("Location", text: $locationText)
                            .font(Styleguide.bodySmall())
                            .foregroundColor(Styleguide.getBlue())
                            .padding(4)
                        
                        Button(action: onLocationTap) {
                            Image(systemName: "location")
                                .font(.system(size: 14))
                                .foregroundColor(Styleguide.getOrange())
                        }
                    }
                    .padding(.horizontal, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Styleguide.getOrange(), lineWidth: 1)
                    )
                }
            }
        }
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Styleguide.getOrange(), lineWidth: 1)
        )
    }
}
