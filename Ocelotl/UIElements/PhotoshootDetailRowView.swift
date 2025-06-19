//
//  PhotoshootDetailRowView.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 05/06/2025.
//

import SwiftUI
import CoreLocation

struct PhotoshootDetailRowView: View {
    @Binding var event: PhotoshootEvent
    var index: Int
    var onLocationTap: () -> Void
    var isSunsetEvent: Bool = false
    var weather: EventWeatherData?
    
    @State private var time: Date = Date()
    @State private var descriptionText: String = ""
    @State private var locationNameText: String = ""
    
    var body: some View {
        HStack(spacing: 0) {
            // Godzina
            VStack {
                DatePicker(
                    "",
                    selection: Binding(
                        get: { event.time ?? Date() },
                        set: { event.time = $0 }
                    ),
                    displayedComponents: [.hourAndMinute]
                )
                .labelsHidden()
                .datePickerStyle(.compact)
                .frame(width: 80)
                .clipped()
                .foregroundColor(Styleguide.getBlue())
                .tint(Styleguide.getBlue())
            }
            .padding(.horizontal, 4)
            .frame(maxHeight: .infinity)
            
            Divider().frame(width: 1).background(Styleguide.getOrange())
            
            // Opis i lokalizacja
            VStack(alignment: .leading, spacing: 4) {
                TextField("Description", text: $descriptionText)
                    .font(Styleguide.body())
                    .foregroundColor(Styleguide.getBlue())
                
                HStack(spacing: 4) {
                    TextField("Location", text: $locationNameText)
                        .font(Styleguide.body())
                        .foregroundColor(Styleguide.getBlue())
                        .padding(4)
                    
                    Button(action: onLocationTap) {
                        Image(systemName: "location")
                            .foregroundColor(Styleguide.getOrange())
                    }
                }
                .padding(.horizontal, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Styleguide.getOrange(), lineWidth: 1)
                )
            }
            .padding(8)
            .frame(maxWidth: .infinity)
            
            Divider().frame(width: 1).background(Styleguide.getOrange())
            
            // Pogoda
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
            .frame(width: 80)
            .padding(8)
        }
        .background(isSunsetEvent
                    ? Styleguide.getOrangeTotallyOpaque()
                    : index.isMultiple(of: 2)
                    ? Styleguide.getBlueTotallyOpaque()
                    : Styleguide.getAlmostWhite()
        )
        .onAppear {
            time = event.time ?? Date()
            descriptionText = event.eventDescription
            locationNameText = event.locationName
        }
        .onChange(of: event.locationName) { _, newValue in
            locationNameText = newValue
        }
    }
}
