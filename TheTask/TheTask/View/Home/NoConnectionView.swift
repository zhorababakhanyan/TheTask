//
//  NoConnectionView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 27/04/2025.
//

import SwiftUI
import Network

struct NoConnectionView: View {
    
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel: NoConnectionViewModel
    
    init(appState: AppState) {
        _viewModel = StateObject(wrappedValue: NoConnectionViewModel(appState: appState))
    }
    
    var body: some View {
        ZStack {
            Color.primaryBackgroundColor
                .ignoresSafeArea(.all)
            VStack (alignment: .center, spacing: 24){
                getOfflineStatusView()
                PrimaryFilledButton(title: "Try again", state: .normal) {
                    viewModel.checkNetworkConnection()
                }
                .alert(isPresented: $viewModel.showAlert) {
                      Alert(
                        title: Text(viewModel.alertTitle),
                        message: Text(viewModel.alertMessage),
                        dismissButton: .default(Text("OK"))
                      )
                  }
            }
        }
    }
}

// MARK: - NoConnectionView Content

// getOfflineStatusView()
/// This function returns a view displaying a "No Internet" image and a warning message.
extension NoConnectionView {
    /// - Parameters:
    ///   - warningMessage: A `String` that provides the message to be displayed when the network is unavailable.
    /// - Returns: A `VStack` containing an image and a text view with the provided warning message.
    func getOfflineStatusView() -> some View {
        VStack (spacing: 24) {
            Image("NoInternet_Image")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text(viewModel.warningMessage)
                .customFont(.regular_400, size: 20, color: .primaryTextColor)
        }
    }
}
