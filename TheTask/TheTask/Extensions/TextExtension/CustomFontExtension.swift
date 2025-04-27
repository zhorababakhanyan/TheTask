//
//  CustomFontExtension.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 27/04/2025.
//

import SwiftUI

// MARK: - Font Types
/// Enum representing different font types used in the app.
enum FontType: String {
    /// Regular font style using 'NunitoSans-Regular' - Weight 400.
    case regular = "NunitoSans-Regular"
    
    /// Semi-bold font style using 'NunitoSans-SemiBold' - Weight 600.
    case semiBold = "NunitoSans-SemiBold"
}

// MARK: - Custom Font Extension
/// Extension for customizing the font and color of a Text view.
extension Text {
    /// Applies a custom font and color to the Text view.
    ///
    /// - Parameters:
    ///   - font: The `FontType` to be applied to the text.
    ///   - size: The size of the font.
    ///   - color: The color to apply to the text.
    /// - Returns: A modified `Text` view with the custom font and color.
    func customFont(_ font: FontType, size: CGFloat, color: Color)  -> Text {
        self
            .font(.custom(font.rawValue, size: size))
            .foregroundStyle(color)
    }
}     
