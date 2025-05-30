//
//  Header.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import SwiftUI

public struct Header: View {
    public var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "globe.europe.africa")
                .font(.system(size: 20))
            Text("Warsaw, MZ")
                .font(Styleguide.h6Bold())
            Spacer()
            Image(systemName: "location")
                .font(.system(size: 20))
                .foregroundColor(Styleguide.getOrange())
        }
        .padding(16)
        .foregroundColor(Styleguide.getBlue())
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Styleguide.getBlue()), alignment: .bottom)
    }
}
