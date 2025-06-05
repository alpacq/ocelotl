//
//  GenericRowView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 03/06/2025.
//

import SwiftUI

struct EventRowView<T: Event>: View {
    let item: T
    let isEven: Bool
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Text(item.date.formatted(date: .numeric, time: .omitted))
                .frame(width: 100, alignment: .trailing)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .foregroundColor(Styleguide.getBlue())
            
            Divider()
                .frame(width: 1, height: 40)
                .background(Styleguide.getOrange())
            
            Text(item.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .foregroundColor(Styleguide.getBlue())
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(Styleguide.getBlue())
            }
            .padding(.trailing, 16)
        }
        .padding(.leading, 8)
        .background(isEven ? Styleguide.getBlueTotallyOpaque() : Styleguide.getAlmostWhite())
        .font(Styleguide.body())
    }
}
