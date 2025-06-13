//
//  CustomDatePicker.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 13/06/2025.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var date: Date
    @State private var showSheet = false
    
    var body: some View {
        Button {
            showSheet = true
        } label: {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(Styleguide.getOrange())
                Text(date.formatted(.dateTime.day().month().hour().minute()))
                    .font(Styleguide.body())
                    .foregroundColor(Styleguide.getBlue())
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Styleguide.getOrange())
            }
            .padding(8)
            .background(Styleguide.getAlmostWhite())
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Styleguide.getOrange(), lineWidth: 1)
            )
        }
        .sheet(isPresented: $showSheet) {
            VStack(spacing: 24) {
                DatePicker("Pick a date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.graphical)
                    .padding()
                    .tint(Styleguide.getOrange())
                
                Button("Done") {
                    showSheet = false
                }
                .font(Styleguide.bodySmall())
                .padding()
                .background(Styleguide.getOrange())
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding()
            .background(Styleguide.getAlmostWhite())
        }
    }
}
