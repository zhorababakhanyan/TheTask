//
//  RequestStage.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 28/04/2025.
//

import Foundation

// MARK: - Network Request Cases
/// Enum representing the two stages of request time tracking:
/// - `getRequest`: Represents the time taken for a GET request.
/// - `postRequest`: Represents the time taken for a POST request.
enum RequestStage {
    case getRequest
    case postRequest
}
