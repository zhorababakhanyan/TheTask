//
//  HomeViewModel.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 29/04/2025.
//

import Foundation

@MainActor 
final class HomeViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var errorMessage: String? = nil
    
    private var nextURL: String? = nil
}

// MARK: - Networking
// MARK: - GetUsers
/// Fetches the initial set of users from the network.
extension HomeViewModel {
    /// This function sets the loading state to `true` while fetching the users, and updates the `users` array
    /// with the fetched data. It also updates the `nextURL` for pagination if there are more users to fetch.
    /// - Parameters: The function fetches the initial set of users without requiring any external parameters.
    /// - Returns: The function performs asynchronous network requests and updates the state of the view model.
    /// - Throws: Error: If the network request fails, the error is caught and logged to the console.
    func getUsers() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await NetworkManager.getInitialUsers()
            self.users = response.users ?? []
            self.nextURL = response.links?.nextURL
            self.errorMessage = nil
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to load users. Please check your internet connection."
            }
            print("Failed to load users:", error.localizedDescription)
        }
    }
}

// MARK: - LoadMoreUsers
/// Loads more users from the network based on the next URL for pagination.
extension HomeViewModel {
    /// This function checks if there's a `nextURL` available for fetching the next page of users.
    /// It sets the loading state to `true` while fetching, and appends the newly fetched users to
    /// the existing `users` array. It also updates the `nextURL` for further pagination if available.
    /// - Parameters: None - The function automatically uses the `nextURL` stored in the view model to fetch more users.
    /// - Returns: Void - This function performs an asynchronous network request and updates the state of the view model.
    /// - Throws: Error: If the network request fails, the error is caught and logged to the console.
    func loadMoreUsers() async {
        guard let nextURL, !isLoadingMore else { return }
        
        isLoadingMore = true
        defer { isLoadingMore = false }
        
        do {
            let response = try await NetworkManager.fetchUsers(from: nextURL)
            let newUsers = response.users ?? []
            self.users += newUsers
            self.nextURL = response.links?.nextURL
            self.errorMessage = nil
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to load more users. Please check your internet connection."
            }
            print("Failed to load more users:", error.localizedDescription)
        }
    }
}
