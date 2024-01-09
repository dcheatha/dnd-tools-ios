//
//  ColorExtensions.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

extension Color {
    static var randomHue: Color {
        return Color(hue: .random(in: 0.0...1.0), saturation: 0.5, brightness: 1.0)
    }
    
    static func hue(_ value: CGFloat) -> Color {
        return Color(hue: value, saturation: 0.5, brightness: 1.0)
    }
    
    static func signatureHue(_ value: AnyHashable) -> Color {
        let signature = value.hashValue % 10_000
        let hue: CGFloat = CGFloat(signature) / 10_000.0
        return Color(hue: hue, saturation: 0.5, brightness: 1.0)
    }
}
  
