//
//  Untitled.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: self)
    }
}

extension Date {
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.day, from: self) == calendar.component(.day, from: otherDate) &&
        calendar.component(.month, from: self) == calendar.component(.month, from: otherDate) &&
        calendar.component(.year, from: self) == calendar.component(.year, from: otherDate)
    }
    
    func formattedWithOrdinal() -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self).ordinalString
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        let month = formatter.string(from: self)
        
        let year = calendar.component(.year, from: self)
        
        return "\(month) \(day), \(year)"
    }
}

extension Int {
    var ordinalString: String {
        let suffix: String
        
        switch self % 100 {
        case 11, 12, 13:
            suffix = "th"
        default:
            switch self % 10 {
            case 1: suffix = "st"
            case 2: suffix = "nd"
            case 3: suffix = "rd"
            default: suffix = "th"
            }
        }
        
        return "\(self)\(suffix)"
    }
}

