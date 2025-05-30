//
//  WeekWeatherStack.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 25/05/2025.
//

import SwiftUI

struct WeekWeatherStack: View {
    var body: some View {
        VStack (spacing: 24) {
            VStack {
                HStack(alignment: .center) {
                    DayWeatherStack()
                    Spacer()
                    DayWeatherStack()
                    Spacer()
                    DayWeatherStack()
                    Spacer()
                    DayWeatherStack()
                    Spacer()
                    DayWeatherStack()
                    Spacer()
                    DayWeatherStack()
                    Spacer()
                    DayWeatherStack()
                }
                .padding(12)
            }
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Styleguide.getOrange()), alignment: .top)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Styleguide.getOrange()), alignment: .bottom)
            
            WeekDayToggle()
        }
    }
}
