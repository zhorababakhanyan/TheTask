//
//  LaunchScreen.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 27/04/2025.
//

import SwiftUI

struct LaunchScreen: View {
    @Binding var isActive: Bool

    var body: some View {
        ZStack {
            Color.launchScreenBackgroundColor.ignoresSafeArea(.all)
            self.getLunchScreenContent()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isActive = true
            }
        }
    }
}

// MARK: - LaunchScreen Content
/// GetLunchScreenContent()
extension LaunchScreen {
    /// - Parameters: None
    /// - Returns: A `VStack` containing two `Image` views (`LogoPrimary` and `LogoText`).
    func getLunchScreenContent() -> some View {
        VStack(alignment: .center, spacing: 15) {
            Image("LogoPrimary")
            Image("LogoText")
        }
    }
}
