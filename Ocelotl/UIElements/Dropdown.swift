//
//  Dropdown.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

public struct Dropdown: View {
    @Binding var isExpanded: Bool
    @Binding var selectedOption: String
    let options: [String]
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selectedOption = option
                            isExpanded = false
                        }) {
                            Text(option)
                                .font(Styleguide.bodySmall())
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Styleguide.getAlmostWhite())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .background(Styleguide.getAlmostWhite())
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Styleguide.getOrange(), lineWidth: 1)
                )
            }
        }
    }
}
