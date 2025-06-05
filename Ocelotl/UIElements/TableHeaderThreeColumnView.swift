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
                .frame(width: 80, alignment: .trailing)
                .foregroundColor(Styleguide.getBlue())
            
            Divider().frame(width: 1).background(Styleguide.getOrange())
            
            Image(systemName: "text.bubble")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Styleguide.getBlue())
            
            Divider().frame(width: 1).background(Styleguide.getOrange())
            
            Image(systemName: "thermometer.sun")
                .frame(width: 80, alignment: .leading)
                .foregroundColor(Styleguide.getBlue())
        }
        .background(Styleguide.getAlmostWhite())
        .font(Styleguide.body())
        .overlay(Rectangle().frame(height: 1).foregroundColor(Styleguide.getOrange()), alignment: .bottom)
    }
}
