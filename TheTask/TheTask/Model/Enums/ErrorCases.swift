//
//  ErrorCases.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 29/04/2025.
//

import Foundation

/// Represents various error cases that can occur during network-related operations.
///
/// Conforms to `LocalizedError` to provide user-friendly error descriptions.
enum ErrorCases: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL found"
        case .invalidResponse:
            return "Invalid Response Found"
        case .invalidData:
            return "Invalid Data Found"
        case .networkError:
            return "Network Error"
        }
    }
}
