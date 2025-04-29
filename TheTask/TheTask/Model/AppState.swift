//
//  AppState.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 27/04/2025.
//

import Foundation

// MARK: - AppState
/// This class is responsible for managing the global state of the app.
/// It conforms to `ObservableObject` to allow other views to observe and react to state chnges.
class AppState: ObservableObject {
    @Published var isLunchScreenActive: Bool = false
    @Published var isInternetAvailable: Bool = true
    
    private var networkMonitor = NetworkMonitor.shared

    init() {
        networkMonitor.$isConnected
            .assign(to: &$isInternetAvailable)
    }
    
    func appDidEnterBackground() {
        networkMonitor.stopMonitoring()
        print("🟡 App entered background – monitoring stopped")
    }

    func appWillEnterForeground() {
        networkMonitor.startMonitoring()
        print("🟢 App entered foreground – monitoring started")
    }
}
