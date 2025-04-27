//
//  NetworkMonitor.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 27/04/2025.
//

import Foundation
import Network

// MARK: - NetworkMonitor
/// This class uses the `Network` freamwork to monitor internet connectivity.
class NetworkMonitor: ObservableObject {
    
    private var monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected: Bool = true
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
