//
//  PrimaryInputTextField.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 29/04/2025.
//

import SwiftUI
import UIKit

struct PrimaryInputTextField: View {
    let title: String
    let fieldInfo: String
    let emptyFieldError: String?
    let focusID: FieldFocus
    
    @Binding var text: String
    @FocusState.Binding var focused: FieldFocus?
        
    var isFocused: Bool {
        focused == focusID
    }
    
    var isErrored: Bool {
        emptyFieldError != nil
    }
    
    var body: some View {
        VStack (alignment: .leading){
            ZStack(alignment: .leading) {
                TextField("", text: $text)
                    .customFont(
                        .regular_400,
                        size: 16,
                        color: (isFocused || !text.isEmpty) ? .primaryTextColor : .secondaryTextColor
                    )
                    .keyboardType(FunctionManager.shared.keyboardTypeFor(focusID))
                    .padding(.leading, 15)
                    .padding(.bottom, isFocused || !text.isEmpty ? -20 : 0)
                    .frame(height: 56)
                    .focused($focused, equals: focusID)
                    .onSubmit {
                        switch focused {
                        case .name:
                            focused = .email
                        case .email:
                            focused = .phone
                        case .phone:
                            focused = nil
                        case nil:
                            focused = nil
                        }
                    }
                    .tint(Color.primaryTextColor)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(
                                isErrored
                                ? .errorColor
                                : (isFocused ? Color.primaryTextFieldColorEnabledFocused : Color.primaryTextFieldColorEnabled),
                                lineWidth: 1
                            )
                    )
                
                self.inputTextFieldTitle()
            }
            self.fieldInfoText()
        }
    }
}
//MARK: - InputTextFieldTitle
extension PrimaryInputTextField {
    /// Returns a styled title for the input field.
    ///
    /// - Parameters:
    ///   - title: The placeholder or label shown as the field title.
    ///   - text: The bound text value of the input field.
    ///   - isFocused: A Boolean indicating whether the field is currently focused.
    ///   - isErrored: A Boolean indicating whether there is a validation error.
    ///
    /// The title shrinks and shifts upward when the field is focused or has text,
    /// and its color changes based on focus and error state.
    func inputTextFieldTitle() -> some View {
        Text(title)
            .customFont(.regular_400,
                        size: (isFocused || !text.isEmpty ? 12 : 16),
                        color: isErrored
                        ? .errorColor
                        : (isFocused ? .primaryTextFieldColorEnabledFocused : .primaryTextFieldColorEnabled))
            .background(Color.clear)
            .padding(.leading)
            .offset(y: isFocused || !text.isEmpty ? -12 : 0)
    }
}

//MARK: - FieldInfoText
extension PrimaryInputTextField {
    /// Returns a styled informational text shown below the input field.
    /// If there is an error, it shows the error message instead.
    /// For example, expected phone number format: +38(XXX) XXX -XX -XX
    func fieldInfoText() -> some View {
        Text(isErrored ? emptyFieldError! : fieldInfo)
            .customFont(.regular_400, size: 12,
                        color: isErrored
                        ? .errorColor
                        : (isFocused ? .primaryTextFieldColorEnabledFocused : .secondaryTextColor))
            .padding(.leading, 16)
    }
}
