//
//  ShootingEventRowView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 11/06/2025.
//

import SwiftUI

struct ShootingEventRowView: View {
    @Binding var event: ShootingEvent
    
    @State private var localTime: Date = Date()
    @State private var locationText: String = ""
    @State private var descriptionText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                DatePicker("", selection: Binding(
                    get: { event.time ?? Date() },
                    set: { event.time = $0 }
                ), displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
                .frame(maxWidth: .infinity)
                
                TextField("Location", text: $event.locationName)
                    .frame(maxWidth: .infinity)
                
                Image(systemName: "location")
                    .foregroundColor(Styleguide.getOrange())
            }
            
            TextField("description", text: $event.eventDescription)
                .font(Styleguide.body())
                .foregroundColor(Styleguide.getBlue())
            
            // Można dodać ForecastBlockView jeśli chcesz tu też pogodę
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Styleguide.getOrange(), lineWidth: 1)
        )
    }
}
