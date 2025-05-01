//
//  FunctionManager.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 30/04/2025.
//

import SwiftUI

class FunctionManager {
    static let shared = FunctionManager()
    
    private init() {}
    
    /// Validates a name to ensure it falls within the accepted length range.
    ///
    /// - Parameter name: The name string entered by the user.
    /// - Returns: `nil` if the name is between 2 and 60 characters long, otherwise returns an error message string.
    func validateName(_ name: String) -> String? {
        return (name.count < 2 || name.count > 60) ? "Name must be 2–60 characters" : nil
    }
    
    /// Validates an email address using a regular expression pattern.
    ///
    /// - Parameter email: The email address string entered by the user.
    /// - Returns: `nil` if the email is in a valid format, otherwise returns an error message string.
    func validateEmail(_ email: String) -> String? {
        let pattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        let isValid = NSPredicate(format: "SELF MATCHES[c] %@", pattern).evaluate(with: email)
        return isValid ? nil : "Invalid email format"
    }
    
    /// Validates a Ukrainian phone number based on specific rules.
    ///
    /// - Parameter phone: The phone number string entered by the user.
    /// - Returns: `nil` if the phone number is valid (starts with `+380` and contains 13 characters total),
    ///            otherwise returns an error message string.
    func validatePhone(_ phone: String) -> String? {
        let digits = phone.filter { "0123456789+".contains($0) }
        let isValid = digits.count == 13 && digits.hasPrefix("+380")
        return isValid ? nil : "Phone must start with +380 and be 12 digits"
    }
    
    /// Returns the appropriate `UIKeyboardType` for the specified field type.
    ///
    /// - Parameter type: The `FieldFocus` value indicating the kind of input field.
    ///   For example, `.email` returns `.emailAddress`, `.phone` returns `.numbersAndPunctuation`,
    func keyboardTypeFor(_ type: FieldFocus) -> UIKeyboardType {
        if type == .email {
            return .emailAddress
        } else if type == .phone, #available(iOS 14.0, *) {
            return .numbersAndPunctuation
        } else {
            return .default
        }
    }
}
