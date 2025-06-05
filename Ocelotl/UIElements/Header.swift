//
//  Header.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import SwiftUI

public struct Header: View {
    @Binding public var title: String
    public let headerIcon: String
    public let actionIcons: [String]?
    public var actionHandlers: [(() -> Void)]?
    
    public var body: some View {
        HStack(spacing: 16) {
            Image(systemName: headerIcon)
                .font(.system(size: 20))
            Text(title)
                .font(Styleguide.h6Bold())
            Spacer()
            
            if let icons = actionIcons, let handlers = actionHandlers {
                ForEach(icons.indices, id: \.self) { index in
                    if index < handlers.count {
                        Button(action: handlers[index]) {
                            Image(systemName: icons[index])
                                .font(.system(size: 20))
                                .foregroundColor(Styleguide.getOrange())
                                //.padding(.trailing, index == icons.count - 1 ? 16 : 0)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(16)
        .foregroundColor(Styleguide.getBlue())
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Styleguide.getBlue()), alignment: .bottom)
    }
}
