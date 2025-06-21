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
    
    @Binding var expandedDropdown: (UUID, String)?
    let setExpanded: ((UUID, String)?) -> Void
    
    private func dropdownBinding(for type: String) -> Binding<String> {
        switch type {
        case "fps": return $shot.fps
        case "scene": return $shot.scene
        case "framing": return $shot.framing
        default: return .constant("")
        }
    }
    
    private func dropdownOptions(for type: String) -> [String] {
        switch type {
        case "fps": return fpsOptions
        case "scene": return sceneOptions
        case "framing": return framingOptions
        default: return []
        }
    }
    
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
                if let type = expandedDropdown?.1, expandedDropdown?.0 == shot.id {
                    dropdownBlock(type: type)
                } else {
                    VStack(spacing: 8) {
                        collapsedDropdown("fps", value: shot.fps)
                        collapsedDropdown("scene", value: shot.scene)
                        collapsedDropdown("framing", value: shot.framing)
                    }
                }
            }
        }
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Styleguide.getOrange(), lineWidth: 1)
        )
        .background(Styleguide.getAlmostWhite())
        .listRowBackground(Styleguide.getAlmostWhite())
    }
    
    @ViewBuilder
    private func dropdownBlock(type: String) -> some View {
        Dropdown(
            isExpanded: true,
            selectedOption: dropdownBinding(for: type),
            options: dropdownOptions(for: type),
            onTap: { setExpanded(nil) }
        )
    }
    
    @ViewBuilder
    private func collapsedDropdown(_ type: String, value: String) -> some View {
        Button(action: {
            setExpanded((shot.id, type))
        }) {
            HStack {
                Text(value).font(Styleguide.body())
                Spacer()
                Image(systemName: "chevron.down")
            }
            .padding(8)
            .background(Styleguide.getAlmostWhite())
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Styleguide.getOrange(), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
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
