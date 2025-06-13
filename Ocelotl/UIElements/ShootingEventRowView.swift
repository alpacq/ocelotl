//
//  ShootingEventRowView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 11/06/2025.
//

import SwiftUI

struct ShootingEventRowView: View {
    @Binding var event: ShootingEvent
    var onLocationTap: () -> Void
    
    @State private var localTime: Date = Date()
    @State private var locationText: String = ""
    @State private var descriptionText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                CustomDatePicker(date: Binding(
                    get: { event.time ?? Date() },
                    set: { event.time = $0 }
                ))
//                DatePicker("", selection: Binding(
//                    get: { event.time ?? Date() },
//                    set: { event.time = $0 }
//                ), displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
                .font(Styleguide.bodySmall())
                .foregroundColor(Styleguide.getBlue())
                .frame(maxWidth: .infinity)
                
                HStack(spacing: 4) {
                    TextField("Location", text: $locationText)
                        .font(Styleguide.bodySmall())
                        .foregroundColor(Styleguide.getBlue())
                        .padding(4)
                    
                    Button(action: onLocationTap) {
                        Image(systemName: "location")
                            .font(.system(size: 14))
                            .foregroundColor(Styleguide.getOrange())
                    }
                }
                .padding(.horizontal, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Styleguide.getOrange(), lineWidth: 1)
                )
            }
            
            HStack {
                TextField("description", text: $event.eventDescription)
                    .font(Styleguide.body())
                    .foregroundColor(Styleguide.getBlue())
                
                Divider().frame(width: 1).background(Styleguide.getOrange())
                
                // Można dodać ForecastBlockView jeśli chcesz tu też pogodę
            }
        }
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Styleguide.getOrange(), lineWidth: 1)
        )
    }
}
