//
//  Styleguide.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 15/04/2025.
//

import Foundation
import SwiftUI

class Styleguide {
    static let identifier: String = "[Styleguide]"
    
    // MARK: Lifecycle
    init() {
        debugPrint("\(Styleguide.identifier) Initializing.")
    }
    
    // MARK: Colors
    static func getAlmostWhite() -> Color {
        return Colors.almostWhite
        
    }
    
    static func getBlue() -> Color {
        return Colors.blueNonOpaque
    }
    
    static func getOrange() -> Color {
        return Colors.orangeNonOpaque
    }
    
    static func getBlueOpaque() -> Color {
        return Colors.blueOpaque
    }
    
    static func getOrangeOpaque() -> Color {
        return Colors.orangeOpaque
    }
    
    static func getBlueTotallyOpaque() -> Color {
        return Colors.blueTotallyOpaque
    }
    
    // MARK: Text
    static func h1() -> Font {
        Font.custom("Geist", size: 51)
            .weight(.black)
    }
    
    static func h2() -> Font {
        Font.custom("Geist", size: 44)
            .weight(.black)
    }
    
    static func h3() -> Font {
        Font.custom("Geist", size: 38)
            .weight(.black)
    }
    
    static func h4() -> Font {
        Font.custom("Geist", size: 28)
            .weight(.black)
    }
    
    static func h5() -> Font {
        Font.custom("Geist", size: 21)
            .weight(.bold)
    }
    
    static func h6() -> Font {
        Font.custom("Geist", size: 18)
            .weight(.semibold)
    }
    
    static func h6Bold() -> Font {
        Font.custom("Geist", size: 18)
            .weight(.bold)
    }
    
    static func bodyLargeBold() -> Font {
        Font.custom("Geist", size: 18)
            .weight(.medium)
    }
    
    static func bodyLarge() -> Font {
        Font.custom("Geist", size: 18)
            .weight(.regular)
    }
    
    static func body() -> Font {
        Font.custom("Geist", size: 14)
            .weight(.regular)
    }
    
    static func bodySmall() -> Font {
        Font.custom("Geist", size: 12)
            .weight(.regular)
    }
    
    static func caption() -> Font {
        Font.custom("Geist", size: 11)
            .weight(.regular)
    }
}
