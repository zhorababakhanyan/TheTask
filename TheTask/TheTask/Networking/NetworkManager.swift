//
//  NetworkManager.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 29/04/2025.
//

import Foundation
import SwiftUI
import UIKit

final class NetworkManager {
    
    // MARK: - Fetch Users from URL
    /// This function fetches user data from a given URL string.
    /// It performs the network request, checks the response, and decodes the data into a `UsersResponse` object.
    ///
    /// - Parameters:
    ///   - urlString: The URL string pointing to the API endpoint to fetch users.
    /// - Returns: A `UsersResponse` object containing the users and pagination details.
    /// - Throws: An error if the URL is invalid, if the network request fails, or if the response is not as expected.
    static func fetchUsers(from urlString: String) async throws -> UsersResponse {
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw ErrorCases.invalidResponse
            }
            let decoder = JSONDecoder()
            return try decoder.decode(UsersResponse.self, from: data)
            
        } catch {
            throw ErrorCases.networkError
        }
    }
    
    // MARK: - Get first page users
    /// This function fetches the first page of users from the API.
    /// It constructs the URL for the first page of users and calls the `fetchUsers` function to retrieve the data.
    ///
    /// - Returns: A `UsersResponse` object containing the list of users and pagination details.
    /// - Throws: If the network request fails, it throws an error which is caught and re-thrown for handling by the calling code.
    static func getInitialUsers(page: Int = 1, count: Int = 6) async throws -> UsersResponse {
        let initialURL = "https://frontend-test-assignment-api.abz.agency/api/v1/users?page=\(page)&count=\(count)"
        
        do {
            print("✅ [GET] API call to fetch users succeeded with status 200! ")
            return try await fetchUsers(from: initialURL)
        } catch {
            print("❌ Error fetching initial users: \(error.localizedDescription)")
            throw error
        }
    }
    
    // MARK: Fetch Positions
    /// This function fetches available positions from the API.
    ///
    /// - Returns: A `PositionsResponse` object containing an array of available positions.
    /// - Throws: An error if the URL is invalid, the request fails, or decoding fails.
    static func getPositions() async throws -> PositionsResponse {
        let urlString = "https://frontend-test-assignment-api.abz.agency/api/v1/positions"
        
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw ErrorCases.invalidResponse
            }
            
            let decoder = JSONDecoder()
            return try decoder.decode(PositionsResponse.self, from: data)
        } catch {
            print("❌ Error fetching positions: \(error.localizedDescription)")
            throw ErrorCases.networkError
        }
    }
    
    // MARK: - FetchNewToken
    /// Fetches a new token from the API.
    ///
    /// - This function makes a GET request to the API endpoint to retrieve a new authentication token.
    /// - It handles the network response and checks for a successful status code (200).
    /// - If successful, it decodes the `TokenResponse` and returns the token string.
    ///
    /// - Throws:
    ///   - `UserRegistrationErrorCases.invalidURL` if the URL is malformed.
    ///   - `UserRegistrationErrorCases.invalidResponse` if the response is invalid or not of the expected type.
    ///   - `UserRegistrationErrorCases.tokenExpired` if the API response indicates the token has expired.
    ///   - `UserRegistrationErrorCases.serverError` if the server responds with an error.
    ///
    /// - Returns: A string representing the authentication token.
    static func fetchNewToken() async throws -> String {
        guard let url = URL(string: "https://frontend-test-assignment-api.abz.agency/api/v1/token") else {
            throw UserRegistrationErrorCases.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw UserRegistrationErrorCases.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
            
            if tokenResponse.success {
                return tokenResponse.token
            } else {
                throw UserRegistrationErrorCases.tokenExpired
            }
        default:
            throw UserRegistrationErrorCases.serverError
        }
    }
    
    static func getToken() async throws -> String {
        if let savedToken = UserDefaults.standard.string(forKey: "authToken") {
            return savedToken
        } else {
            // Token not found, fetch a new one
            let token = try await fetchNewToken()
            UserDefaults.standard.set(token, forKey: "authToken")
            return token
        }
    }
    
    /// Registers a new user with the provided details.
    ///
    /// - Parameters:
    ///   - name: The user's name, which must be between 2 and 60 characters.
    ///   - email: The user's email address, which must be a valid email according to RFC2822.
    ///   - phone: The user's phone number, which must start with the country code for Ukraine (+380).
    ///   - positionId: The position ID selected by the user. Position IDs can be obtained through the API method `GET NetworkManager.fetchPositions()`.
    ///   - image: The user's profile photo, which must be in JPG/JPEG format, with a minimum resolution of 70x70px and a size not exceeding 5MB.
    /// - Returns: A `RegisterResponse` object containing the registration result.
    /// - Throws: Various errors depending on the API response or any failure during the request.
    static func registerUser(name: String, email: String, phone: String, positionId: Int, image: UIImage) async throws -> RegisterSuccessResponse {
        guard let url = URL(string: "https://frontend-test-assignment-api.abz.agency/api/v1/users") else {
            throw UserRegistrationErrorCases.invalidURL
        }
        
        var token: String
        token = try await getToken()
        
        let boundary = UUID().uuidString
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(token, forHTTPHeaderField: "Token")
        
        var body = Data()
        
        let params: [String: String] = [
            "name": name,
            "email": email,
            "phone": phone,
            "position_id": "\(positionId)"
        ]
        
        for (key, value) in params {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw UserRegistrationErrorCases.encodingError
        }
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"photo.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw UserRegistrationErrorCases.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 201:
            print("✅ User Registration successful: ")
            return try JSONDecoder().decode(RegisterSuccessResponse.self, from: data)
        case 401:
            token = try await fetchNewToken()
            UserDefaults.standard.set(token, forKey: "authToken")
            
            return try await registerUser(name: name, email: email, phone: phone, positionId: positionId, image: image)
        case 409:
            throw UserRegistrationErrorCases.emailOrPhoneRegistered
        case 422:
            if let validationError = try? JSONDecoder().decode(RegisterResponse.self, from: data) {
                print("🚫 Validation failed:")
                for (field, messages) in validationError.fails {
                    print(" - \(field): \(messages.joined(separator: ", "))")
                }
                throw UserRegistrationErrorCases.validationFailed(details: validationError.fails)
            } else {
                throw UserRegistrationErrorCases.serverError
            }
        default:
            throw UserRegistrationErrorCases.serverError
        }
    }
}
