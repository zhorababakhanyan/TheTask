//
//  PrimaryFilledButton.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 28/04/2025.
//

import SwiftUI

struct PrimaryFilledButton: View {
    var title: String
    var state: PrimaryFilledButtonState
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            if state != .disabled {
                action()
            }
        }) {
            Text(title)
                .customFont(.semiBold_600, size: 18, color: textColor)
                .padding()
                .frame(width: 140, height: 48)
                .background(backgroundColor)
                .cornerRadius(24)
        }
        .disabled(state == .disabled)
    }
}

// MARK: - PrimaryFilledButton Background Color
/// Returns the background color based on the current button state.
extension PrimaryFilledButton {
    private var backgroundColor: Color {
        switch state {
        case .normal:
            return Color.primaryButtonColorNormal
        case .pressed:
            return Color.primaryButtonColorPressed
        case .disabled:
            return Color.primaryButtonColorDisabled
        }
    }
}

// MARK: - PrimaryFilledButton Text Color
/// Returns the button Text color based on the current button state.
extension PrimaryFilledButton {
    private var textColor: Color {
        switch state {
        case .normal:
            return Color.primaryButtonTextColorNormal
        case .pressed:
            return Color.primaryButtonTextColorPressed
        case .disabled:
            return Color.primaryButtonTextColorDisabled
        }
    }
}
