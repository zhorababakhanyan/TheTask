//
//  AssetsColors.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 27/04/2025.
//

import SwiftUI

// MARK: - App Colors
/// This extension defines the app’s custom color palette.
/// Use these colors throughout the app to ensure consistent branding and styling.
/// All colors are centrally managed here to simplify future updates.

extension Color {
    // Background Color
    static let primaryBackgroundColor = Color(hex: "FFFFFF")
    static let launchScreenBackgroundColor = Color(hex: "F4E041")
    
    // Text Color
    static let primaryTextColor = Color(hex: "000000").opacity(0.87)
    static let secondaryTextColor = Color(hex: "000000").opacity(0.60)
    
    static let primaryButtonTextColorNormal = Color(hex: "000000").opacity(0.87)
    static let primaryButtonTextColorPressed = Color(hex: "000000").opacity(0.87)
    static let primaryButtonTextColorDisabled = Color(hex: "000000").opacity(0.48)

    // Button Color
    static let primaryButtonColorNormal = Color(hex: "F4E041")
    static let primaryButtonColorPressed = Color(hex: "FFC700")
    static let primaryButtonColorDisabled = Color(hex: "DEDEDE")
   
    static let secondaryButtonColorNormal = Color(hex: "00BDD3")
    static let secondaryButtonColorPressed = Color(hex: "00BDD3")
    static let secondaryButtonColorDisabled = Color(hex: "000000").opacity(0.48)
    
    
    // Header Color
    static let primaryHeaderColor = Color(hex: "F4E041")
    static let primaryHeaderTextColor = Color(hex: "1D1B20")
    
    // TabBar Color
    static let primaryTabBarBackgroundColor = Color(hex: "F8F8F8")
}
