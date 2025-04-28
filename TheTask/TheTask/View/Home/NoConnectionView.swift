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
                StatusView(statusType: .noInternetConnection)
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
