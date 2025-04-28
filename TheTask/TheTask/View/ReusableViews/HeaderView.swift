//
//  HeaderView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 28/04/2025.
//

import SwiftUI

struct HeaderView: View {
    var stage: RequestStage
    
    var body: some View {
        ZStack {
            Color.primaryHeaderColor
                .ignoresSafeArea(.all)
            VStack {
                self.headerText
                    .customFont(.regular_400, size: 20, color: Color.primaryHeaderTextColor)
            }
        }
        .frame(height: 56)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - HeaderView Text
extension HeaderView {
    /// The header text displayed based on the current request stage.
    ///
    /// It shows different titles for `.getRequest` and `.postRequest`.
    private var headerText: Text {
        switch stage {
        case .getRequest:
            return Text("Working with Get Request")
        case .postRequest:
            return Text("Working with Post Request")
        }
    }
}
