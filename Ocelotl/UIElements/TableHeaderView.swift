//
//  TableHeaderView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 03/06/2025.
//

import SwiftUI

struct TableHeaderView: View {
    let leadingIcon: String
    let trailingIcon: String
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 8)
            
            Image(systemName: leadingIcon)
                .foregroundColor(Styleguide.getBlue())
                .frame(width: 100, alignment: .trailing)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            Divider()
                .frame(width: 1, height: 40)
                .background(Styleguide.getOrange())
            
            Image(systemName: trailingIcon)
                .foregroundColor(Styleguide.getBlue())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            Spacer().frame(width: 40)
        }
        .background(Styleguide.getAlmostWhite())
        .font(Styleguide.body())
        .overlay(Rectangle().frame(height: 1).foregroundColor(Styleguide.getOrange()), alignment: .bottom)
    }
}
