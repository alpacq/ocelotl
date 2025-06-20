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
    var weather: EventWeatherData?
    
    @State private var localTime: Date = Date()
    @State private var locationText: String = ""
    @State private var descriptionText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                CustomDatePicker(date: Binding(
                    get: { event.time ?? Date() },
                    set: { event.time = $0 }
                ))
                .labelsHidden()
                .font(Styleguide.bodySmall())
                .foregroundColor(Styleguide.getBlue())
                .frame(maxWidth: .infinity)
                
                HStack(spacing: 4) {
                    TextField("Location", text: $locationText)
                        .font(Styleguide.body())
                        .foregroundColor(Styleguide.getBlue())
                        .padding(4)
                    
                    Button(action: onLocationTap) {
                        Image(systemName: "location")
                            .font(.system(size: 16))
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
                
                VStack {
                    if let forecast = weather {
                        ForecastBlockView(temperature: forecast.temperature,
                                          rain: forecast.rain,
                                          wind: forecast.wind,
                                          symbolName: forecast.symbolName)
                    } else {
                        Text("-")
                            .font(Styleguide.bodySmall())
                            .foregroundColor(Styleguide.getOrangeOpaque())
                    }
                }
                .frame(width: 120)
            }
        }
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Styleguide.getOrange(), lineWidth: 1)
        )
        .background(Styleguide.getAlmostWhite())
        .listRowBackground(Styleguide.getAlmostWhite())
        .onAppear {
            localTime = event.time ?? Date()
            descriptionText = event.eventDescription
            locationText = event.locationName
        }
        .onChange(of: event.locationName) { _, newValue in
            locationText = newValue
        }
    }
}
