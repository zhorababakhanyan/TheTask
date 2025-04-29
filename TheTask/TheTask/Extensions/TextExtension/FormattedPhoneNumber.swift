//
//  formattedPhoneNumber.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 29/04/2025.
//

import SwiftUI

extension String {
    /// Formats a Ukrainian phone number into the standard format: +38 (XXX) XXX XX XX
    /// - Returns: A formatted Ukrainian phone number string, or the original number if it doesn't match the Ukrainian format.
    ///
    /// - Example:
    ///   ```
    ///   let formattedPhone = "+380936050764".formattedPhoneNumberForUkraine()
    ///   Output: "+38 (093) 605 07 64"
    ///   ```
    func formattedPhoneNumber() -> String {
        let cleanedNumber = self.filter { "+0123456789".contains($0) }
        
        guard cleanedNumber.hasPrefix("+38") else {
            return self //
        }
        
        let digits = String(cleanedNumber.dropFirst(3))
        
        if digits.count >= 10 {
            let area = digits[digits.index(digits.startIndex, offsetBy: 0)..<digits.index(digits.startIndex, offsetBy: 3)]
            let part1 = digits[digits.index(digits.startIndex, offsetBy: 3)..<digits.index(digits.startIndex, offsetBy: 6)]
            let part2 = digits[digits.index(digits.startIndex, offsetBy: 6)..<digits.index(digits.startIndex, offsetBy: 8)]
            let part3 = digits[digits.index(digits.startIndex, offsetBy: 8)..<digits.index(digits.startIndex, offsetBy: 10)]
            
            return "+38 (\(area)) \(part1) \(part2) \(part3)"
        }
        return cleanedNumber
    }
}
