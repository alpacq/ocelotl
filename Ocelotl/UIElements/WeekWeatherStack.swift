//
//  WeekWeatherStack.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 25/05/2025.
//

import SwiftUI

struct WeekWeatherStack: View {
    @ObservedObject var fetcher: WeatherFetcher
    @State private var isDayMode: Bool = true
    
    var body: some View {
        VStack(spacing: 24) {
            
                if isDayMode {
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(fetcher.hourlyWeather.prefix(24)) { hour in
                                HourWeatherStack(
                                    time: hour.time,
                                    icon: hour.icon,
                                    temperature: hour.temperature,
                                    precipitation: hour.precipitation,
                                    windSpeed: hour.windSpeed
                                )
                            }
                        }
                        .padding(12)
                    }
                } else {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(fetcher.dailyWeather.prefix(7)) { day in
                            DayWeatherStack(
                                date: day.date,
                                icon: day.icon,
                                temperature: day.maxTemperature,
                                precipitation: day.precipitation,
                                windSpeed: day.windSpeed
                            )
                            .frame(maxWidth: .infinity)
                        }
                    }
                    //.frame(maxWidth: .infinity)
                    .padding(8)
                }
        }
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Styleguide.getOrange()), alignment: .top)
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Styleguide.getOrange()), alignment: .bottom)
        
        WeekDayToggle(isDayMode: $isDayMode)
    }
}
