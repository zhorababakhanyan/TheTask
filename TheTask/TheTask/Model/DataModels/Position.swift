//
//  Position.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 30/04/2025.
//

import Foundation

/// A model representing the response for fetching a list of positions.
///
/// Conforms to `Codable` for encoding and decoding.
///
/// - Properties:
///   - success: A boolean indicating whether the request for positions was successful.
///   - positions: An array of `Position` objects representing the available positions.
struct PositionsResponse: Codable {
    let success: Bool
    let positions: [Position]
}

/// A model representing a single position.
///
/// Conforms to `Codable` for encoding and decoding.
///
/// - Properties:
///   - id: The unique identifier for the position.
///   - name: The name of the position (e.g., "Security", "Designer").
struct Position: Codable {
    let id: Int
    let name: String
}
