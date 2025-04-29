//
//  NetworkManager.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 29/04/2025.
//

import Foundation

final class NetworkManager {
    
    // MARK: Fetch Users from URL
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
}
