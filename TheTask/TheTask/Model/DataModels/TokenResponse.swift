//
//  TokenResponse.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 01/05/2025.
//

import Foundation

/// A model representing the response from a token request.
///
/// Conforms to `Codable` for easy encoding and decoding of the response data.
///
/// *https://frontend-test-assignment-api.abz.agency/api/v1/token
///
/// - Properties:
///   - success: A boolean indicating whether the token request was successful.
///   - token: The authentication token returned from the server if the request was successful.

struct TokenResponse: Codable {
    let success: Bool
    let token: String
}
