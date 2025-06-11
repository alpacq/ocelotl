//
//  ShotRowView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 11/06/2025.
//

import SwiftUI

struct ShotRowView: View {
    @Binding var shot: Shot
    
    let fpsOptions = ["24 fps", "25 fps", "30 fps"]
    let framingOptions = ["close", "medium", "wide"]
    let sceneOptions = ["ujęcie w domu", "ujęcie na zewnątrz"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("description", text: $shot.shotDescription)
                .font(Styleguide.body())
                .foregroundColor(Styleguide.getBlue())
            
            HStack {
                Picker("FPS", selection: $shot.fps) {
                    ForEach(fpsOptions, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
                
                Picker("Framing", selection: $shot.framing) {
                    ForEach(framingOptions, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
            }
            
            HStack {
                Picker("Scene", selection: $shot.scene) {
                    ForEach(sceneOptions, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
                
                TextField("Location", text: $shot.locationName)
                    .font(Styleguide.body())
                    .padding(.horizontal, 4)
                
                Image(systemName: "location")
                    .foregroundColor(Styleguide.getOrange())
            }
            
            Toggle(isOn: $shot.isCompleted) {
                EmptyView()
            }
            .labelsHidden()
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Styleguide.getOrange(), lineWidth: 1)
        )
    }
}
