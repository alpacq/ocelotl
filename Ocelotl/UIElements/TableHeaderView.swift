//
//  TableHeaderView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 03/06/2025.
//

import SwiftUI

struct TableHeaderView: View {
    var body: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 8)
            
            Image(systemName: "calendar")
                .foregroundColor(Styleguide.getBlue())
                .frame(width: 100, alignment: .trailing)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            Divider()
                .frame(width: 1, height: 40)
                .background(Styleguide.getOrange())
            
            Image(systemName: "camera")
                .foregroundColor(Styleguide.getBlue())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            Spacer().frame(width: 40)
        }
        .background(Styleguide.getAlmostWhite())
        .font(Styleguide.body())
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Styleguide.getOrange()), alignment: .bottom)
    }
}
