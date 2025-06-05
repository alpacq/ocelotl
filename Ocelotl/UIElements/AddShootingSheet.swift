//
//  AddShootingSheet.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 04/06/2025.
//

import SwiftUI

struct AddShootingSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var date = Date()
    let onSave: ((String, Date) -> Void)?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("New shooting")
                        .font(Styleguide.h5())
                        .foregroundColor(Styleguide.getBlue())
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Title")
                            .font(Styleguide.body())
                            .foregroundColor(Styleguide.getBlue())
                        
                        ZStack(alignment: .leading) {
                            if title.isEmpty {
                                Text("Enter title")
                                    .foregroundColor(Styleguide.getOrangeOpaque())
                                    .font(Styleguide.body())
                            }
                            
                            TextField("", text: $title)
                                .font(Styleguide.body())
                                .foregroundColor(Styleguide.getBlue())
                        }
                        
                        Rectangle()
                            .fill(Styleguide.getOrangeOpaque())
                            .frame(height: 1)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Date")
                            .font(Styleguide.body())
                            .foregroundColor(Styleguide.getBlue())
                        
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .accentColor(Styleguide.getBlue())
                        
                        Rectangle()
                            .fill(Styleguide.getOrangeOpaque())
                            .frame(height: 1)
                    }
                }
                .padding()
                .background(Styleguide.getAlmostWhite())
            }
            .background(Styleguide.getAlmostWhite())
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let onSave = onSave {
                            onSave(title, date)
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty)
                    .foregroundColor(Styleguide.getBlue())
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Styleguide.getOrange())
                }
            }
        }
        .background(Styleguide.getAlmostWhite())
    }
}
