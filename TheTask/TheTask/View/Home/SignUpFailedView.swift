//
//  SignUpFailedView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 01/05/2025.
//

import SwiftUI

struct SignUpFailedView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.primaryBackgroundColor
                .ignoresSafeArea()
            VStack(alignment: .center){
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
                StatusView(statusType: StatusType.emailAlreadyRegistered)
                PrimaryFilledButton(title: "Try Again", state: .normal) {
                    dismiss()
                }
                Spacer()
            }
            .padding(.all, 29)
        }
    }
}
