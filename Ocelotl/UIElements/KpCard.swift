//
//  KpCard.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 26/05/2025.
//

import SwiftUI

public struct KpCard: View {
    @ObservedObject var fetcher: KpFetcher
    
    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "safari")
                .font(.system(size: 24))
            if let kp = fetcher.currentKpIndex {
                Text("Kp = \(kp, specifier: "%.2f")")
                    .font(Styleguide.bodyLarge())
            } else {
                Text("Kp = ##")
                    .font(Styleguide.bodyLarge())
            }
        }
        .foregroundColor(Styleguide.getBlue())
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Styleguide.getOrange(), lineWidth: 1)
        )
    }
}
