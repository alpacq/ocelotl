//
//  ShotRowView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 11/06/2025.
//

import SwiftUI

struct ShotRowView: View {
    @Binding var shot: Shot
    var sceneOptions: [String]

    
    let fpsOptions = ["24 fps", "25 fps", "30 fps", "60 fps", "120 fps"]
    let framingOptions = ["detail", "close", "halfclose", "medium", "wide", "far"]
    
    @State private var isFpsExpanded = false
    @State private var fpsSelection: String = ""
    
    @State private var isFramingExpanded = false
    @State private var framingSelection: String = ""
    
    @State private var isSceneExpanded = false
    @State private var sceneSelection: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TextField("description", text: $shot.shotDescription)
                    .font(Styleguide.body())
                    .foregroundColor(Styleguide.getBlue())
                
                Toggle(isOn: $shot.isCompleted) {
                    EmptyView()
                }
                .toggleStyle(CheckboxToggleStyle())
                .labelsHidden()
            }
            
            if !shot.isCompleted {
                HStack {
                    VStack(spacing: 8) {
                        Dropdown(isExpanded: $isFpsExpanded, selectedOption: $fpsSelection, options: fpsOptions)
                            .onAppear {
                                if fpsSelection.isEmpty, let first = fpsOptions.first {
                                    fpsSelection = first
                                }
                            }
                        
                        Dropdown(isExpanded: $isSceneExpanded, selectedOption: $sceneSelection, options: sceneOptions)
                            .onAppear {
                                if sceneSelection.isEmpty, let first = sceneOptions.first {
                                    sceneSelection = first
                                }
                            }
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 8) {
                        Dropdown(isExpanded: $isFramingExpanded, selectedOption: $framingSelection, options: framingOptions)
                            .onAppear {
                                if framingSelection.isEmpty, let first = framingOptions.first {
                                    framingSelection = first
                                }
                            }
                        
                        Spacer()
                    }
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

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .font(.system(size: 18))
                .onTapGesture { configuration.isOn.toggle() }
        }
        .foregroundColor(Styleguide.getBlue())
    }
}
