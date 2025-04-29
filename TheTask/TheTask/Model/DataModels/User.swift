//
//  User.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 29/04/2025.
//

import Foundation

struct UsersResponse: Codable {
    let success: Bool?
    let totalPages: Int?
    let totalUsers: Int?
    let count: Int?
    let page: Int?
    let links: Links?
    let users: [User]?

    enum CodingKeys: String, CodingKey {
        case success
        case totalPages = "total_pages"
        case totalUsers = "total_users"
        case count
        case page
        case links
        case users
    }
}

struct Links: Codable {
    let nextURL: String?
    let prevURL: String?

    enum CodingKeys: String, CodingKey {
        case nextURL = "next_url"
        case prevURL = "prev_url"
    }
}

struct User: Codable, Equatable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let position: String
    let positionId: Int
    let registrationTimestamp: Int
    let photo: String

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, position
        case positionId = "position_id"
        case registrationTimestamp = "registration_timestamp"
        case photo
    }
}
