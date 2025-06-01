//
//  Header.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import SwiftUI

public struct Header: View {
    @Binding public var title: String
    public let icon: String
    public let actionIcon: String
    public var action: (() -> Void)?
    
    public var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
            Text(title)
                .font(Styleguide.h6Bold())
            Spacer()
            Image(systemName: actionIcon)
                .font(.system(size: 20))
                .foregroundColor(Styleguide.getOrange())
        }
        .padding(16)
        .foregroundColor(Styleguide.getBlue())
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Styleguide.getBlue()), alignment: .bottom)
    }
}
