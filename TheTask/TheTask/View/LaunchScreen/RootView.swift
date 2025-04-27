//
//  RootView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 27/04/2025.
//

import SwiftUI

// MARK: - AppState
/// This class is responsible for managing the global state of the app.
/// It conforms to `ObservableObject` to allow other views to observe and react to state changes.
struct RootView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        if appState.isLunchScreenActive {
            if appState.isInternetAvailable {
                HomeView()
            } else {
                NoConnectionView()
            }
        } else {
            LaunchScreen(isActive: $appState.isLunchScreenActive)
        }
    }
}
