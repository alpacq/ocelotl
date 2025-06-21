//
//  Dropdown.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

public struct Dropdown: View {
    let isExpanded: Bool
    @Binding var selectedOption: String
    let options: [String]
    let onTap: (() -> Void)?
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                onTap?()
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
            .contentShape(Rectangle())
            .zIndex(1)
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selectedOption = option
                            onTap?()
                        }) {
                            Text(option)
                                .font(Styleguide.bodySmall())
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Styleguide.getAlmostWhite())
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())
                    }
                }
                .background(Styleguide.getAlmostWhite()).ignoresSafeArea(.all)
                .listRowBackground(Styleguide.getAlmostWhite())
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Styleguide.getOrange(), lineWidth: 1)
                )
                .padding(.bottom, 4)
                .zIndex(2)
            }
            
            Spacer(minLength: 12)
        }
    }
}
