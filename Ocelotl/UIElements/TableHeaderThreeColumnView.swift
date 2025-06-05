//
//  TableHeaderThreeColumnView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 05/06/2025.
//

import SwiftUI

struct TableHeaderThreeColumnView: View {
    var body: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 8)
            
            Image(systemName: "clock")
                .padding(.trailing, 16)
                .frame(width: 80, alignment: .trailing)
                .foregroundColor(Styleguide.getBlue())
            
            Divider()
                .frame(width: 1, height: 40)
                .background(Styleguide.getOrange())
            
            Image(systemName: "character.cursor.ibeam")
                .foregroundColor(Styleguide.getBlue())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            Divider()
                .frame(width: 1, height: 40)
                .background(Styleguide.getOrange())
            
            Image(systemName: "thermometer.sun")
                .foregroundColor(Styleguide.getBlue())
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(width: 96, alignment: .leading)
        }
        .background(Styleguide.getAlmostWhite())
        .font(Styleguide.body())
        .overlay(Rectangle().frame(height: 1).foregroundColor(Styleguide.getOrange()), alignment: .bottom)
    }
}
