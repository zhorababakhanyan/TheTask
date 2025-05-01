//
//  SignUpSuccessView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 01/05/2025.
//

import SwiftUI

struct SignUpSuccessView: View {
    @Binding var selectedTab: Tab
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.primaryBackgroundColor
                .ignoresSafeArea()
            VStack (alignment: .center){
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label : {
                        Image("Xmark")
                            .resizable()
                            .frame(width: 14, height: 14)
                    }
                }
                Spacer()
                StatusView(statusType: StatusType.successfulRegistration)
                PrimaryFilledButton(title: "Got It", state: .normal) {
                    selectedTab = .home
                    dismiss()
                }
                Spacer()
            }
            .padding(.all, 29)
        }
    }
}
