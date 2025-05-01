//
//  UserRegistrationErrorCases.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 30/04/2025.
//

import Foundation

/// Represents various error cases that can occur during user registration.
enum UserRegistrationErrorCases: Error {
    case invalidURL
    case invalidResponse
    case networkError
    case encodingError
    case tokenExpired
    case emailOrPhoneRegistered
    case serverError
    case validationFailed(details: [String: [String]])
}
