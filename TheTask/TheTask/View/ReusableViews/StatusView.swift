//
//  StatusView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 28/04/2025.
//

import SwiftUI

struct StatusView: View {
    var statusType: StatusType
    
    var body: some View {
        VStack (alignment: .center,spacing: 24) {
            self.statusImage()
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            self.statusText()
                .customFont(.regular_400, size: 20, color: .primaryTextColor)
                .multilineTextAlignment(.center)
        }
    }
}
#Preview {
    StatusView(statusType: .emailAlreadyRegistered)
}

// MARK: - StatusView Content
extension StatusView {
    /// Returns the appropriate image based on the current `statusType` or an optional custom image name.
    ///
    /// - Parameter customImageName: A custom image name to override the default image.
    /// - Returns: An `Image` object corresponding to the current status or the custom image.
    private func statusImage(customImageName: String? = nil) -> Image {
        if let customImageName = customImageName {
            return Image(customImageName)
        }
        
        switch self.statusType {
        case .noInternetConnection:
            return Image("NoInternet_Image")
        case .noUsers:
            return Image("NoUsers_Image")
        case .successfulRegistration:
            return Image("SuccessfulRegistration_Image")
        case .emailAlreadyRegistered:
            return Image("EmailAlreadyRegistered_image")
        }
    }
}

extension StatusView {
    /// Return the Text based on the current `statusType` or an optional custom status text.
    ///
    /// - Parameter customStatusText: A custom status Text to override the default Text
    /// - Returns: An `Text` to the current status or the custom Text
    private func statusText(customStatusText: String? = nil) -> Text {
        if let customStatusText = customStatusText {
            return Text(customStatusText)
    
        }
        
        switch self.statusType {
        case .noInternetConnection:
            return Text("There is no internet connection")
        case .noUsers:
            return Text("There are no users yet ")
        case .successfulRegistration:
            return Text("User successfully registered")
        case .emailAlreadyRegistered:
            return Text("That Email or Phone number is already registered")
        }
    }
}

