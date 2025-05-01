//
//  SignUpViewModel.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 30/04/2025.
//

import Foundation
import UIKit
import SwiftUI

@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var positions: [Position] = []
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var registerUserIsLoading: Bool = false
    @Published var registrationResponse: RegisterSuccessResponse?
    
    @Published var registerUserErrorMessage: String?
    @Published var emailAlreadyRedigtered: Bool = false
    @Published var anyOtherRegistrationIssueFinded: Bool = false
}

// MARK: - Fetching User Position
// Returns a list of all available user positions.
extension SignUpViewModel {
    /// Fetches the list of available user positions from the API.
    ///
    /// This function makes an asynchronous network request to retrieve the available user positions
    /// and updates the `positions` property upon success. If the request fails, it sets an error message
    /// in `errorMessage` and updates the `isLoading` state to indicate whether the fetch operation is in progress.
    ///
    /// - Note: The function handles errors by catching exceptions and providing a localized error message.
    func fetchPositions() async {
        self.isLoading = true
        defer { self.isLoading = false }

        do {
            let response = try await NetworkManager.getPositions()
            self.positions = response.positions
        } catch {
            self.errorMessage = "Faild to fetch positions \(error.localizedDescription)"
        }
        self.isLoading = false
    }
}

// MARK: - Registering User
extension SignUpViewModel {
    /// Registers a new user with the provided information.
      ///
      /// This function validates the provided user data (name, email, phone, position ID, and photo),
      /// then attempts to register the user by making a network request. It handles different types of errors
      /// (expired token, email or phone already registered) and updates the view model accordingly.
      ///
      /// - Parameters:
      ///   - name: The user's name, which must be between 2 and 60 characters.
      ///   - email: The user's email address, which must be a valid email according to RFC2822.
      ///   - phone: The user's phone number, which must start with the country code for Ukraine (+380).
      ///   - positionId: The position ID selected by the user. Position IDs can be obtained through the API method `GET ViewModel.fetchPositions()`.
      ///   - image: The user's profile photo, which must be in JPG/JPEG format, with a minimum resolution of 70x70px and a size not exceeding 5MB.
      ///
      /// - Throws: A `UserRegistrationError` if registration fails due to issues like token expiration or a previously registered email/phone or any other faults out of API Requirments .
      ///
      /// - Note: On success, the registration response is stored in `registrationResponse` and printed to the console.
    func registerUser(name: String, email: String, phone: String, positionId: Int, image: UIImage) async {
        self.registerUserIsLoading = true
        self.registerUserErrorMessage = nil
        
        do {
            let response = try await NetworkManager.registerUser(name: name, email: email, phone: phone, positionId: positionId, image: image)
            
            self.registrationResponse = response

        } catch let error as UserRegistrationErrorCases {
            switch error {
            case .tokenExpired:
                self.registerUserErrorMessage = "Token expired. Please re-login."
            case .emailOrPhoneRegistered:
                self.emailAlreadyRedigtered = true
                self.registerUserErrorMessage = "The email or phone number is already registered."
            default:
                self.registerUserErrorMessage = "An unexpected error occurred: \(error.localizedDescription)"
            }
        } catch {
            self.registerUserErrorMessage = "An error occurred: \(error.localizedDescription)"
        }
        self.registerUserIsLoading = false
    }
}
