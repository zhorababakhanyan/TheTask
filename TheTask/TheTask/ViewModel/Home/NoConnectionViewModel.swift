//
//  NoConnectionViewModel.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 28/04/2025.
//

import SwiftUI

class NoConnectionViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var alertTitle = "No Internet Connection 🚫"
    @Published var alertMessage = "Please check your network settings"
    @Published var warningMessage = "There is no interent connection"
    
    private var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
}

// MARK: - Extensions
/// Checks the network connection status and updates the app state accordingly.
extension NoConnectionViewModel {
    /// - If the internet is available, it deactivates the launch screen.
    /// - If the internet is unavailable, it shows an alert to the user.
    ///
    /// - Parameters: None
    /// - Returns: Void
    func checkNetworkConnection() {
        if appState.isInternetAvailable {
            appState.isLunchScreenActive = false
        } else {
            showAlert = true
        }
    }
}
