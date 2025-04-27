//
//  ColorHexExtension.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 27/04/2025.
//

import SwiftUI

//MARK: - Color Hex Initializer
/// This extension allows initialization of Colors using HEX string values.
/// It supports standard 6-digit (#RRGGBB) and 8-digit (#RRGGBBAA) HEX formats.
/// Useful for consistent color definitions when working with design systems.

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
