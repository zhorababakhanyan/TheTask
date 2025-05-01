//
//  RegistrationResponse.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 30/04/2025.
//

import Foundation

/// A model representing the response from a user registration request.
///
/// Conforms to `Codable` for encoding and decoding, and `Equatable` for comparison.
///
/// - Properties:
///   - success: A boolean indicating whether the registration request was successful.
///   - message: A message returned from the server, typically an error or success message.
///   - fails: A dictionary containing field names as keys and arrays of error messages as values.
struct RegisterResponse: Codable, Equatable {
    let success: Bool
    let message: String
    let fails: [String: [String]]
}

/// A model representing the validation error response from a registration request.
///
/// Conforms to `Codable` for encoding and decoding.
///
/// - Properties:
///   - success: A boolean indicating whether the validation process was successful.
///   - message: A message from the server regarding validation results.
///   - fails: A dictionary containing the failed fields and their respective error messages.
struct RegisterValidationErrorResponse: Codable {
    let success: Bool
    let message: String
    let fails: [String: [String]]
}


/// A model representing the success response after a successful registration.
///
/// Conforms to `Codable` for encoding and decoding, and `Equatable` for comparison.
///
/// - Properties:
///   - success: A boolean indicating that the registration was successful.
///   - user_id: The unique identifier of the newly registered user.
///   - message: A success message returned from the server.
struct RegisterSuccessResponse: Codable, Equatable {
    let success: Bool
    let user_id: Int
    let message: String
}
