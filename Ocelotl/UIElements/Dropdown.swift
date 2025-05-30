//
//  Dropdown.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

public struct Dropdown: View {
    @Namespace private var animationNamespace
    @State private var isExpanded = false
    @State private var selectedOption = "Select an Option"
    let options = ["DJI Mini 3", "DJI Mini 3 Pro", "DJI Mini 4 Pro"]
    
    public var body: some View {
        VStack {
            Button(action: {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(selectedOption)
                        .font(Styleguide.body())
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                .padding(8)
                .background(Styleguide.getAlmostWhite())
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Styleguide.getOrange(), lineWidth: 1)
                )
            }
            
            if isExpanded {
                VStack {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                            .font(Styleguide.body())
                            .padding(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Styleguide.getAlmostWhite())
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedOption = option
                                    isExpanded = false
                                }
                            }
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Styleguide.getOrange(), lineWidth: 1)
                )
            }
        }
    }
}
