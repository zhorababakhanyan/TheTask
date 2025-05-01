//
//  UploadPictureView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 30/04/2025.
//

import SwiftUI

struct UploadPictureView: View {
    var imageUploaded: Bool
    var showValidation: Bool
    var action: () -> Void
    
    var body: some View {
        let shouldShowError = showValidation && !imageUploaded
        
        VStack(alignment: .leading) {
            HStack {
                Text(imageUploaded ? "Photo Uploaded" : "Upload your Photo")
                    .customFont(
                        .regular_400,
                        size: 16,
                        color: shouldShowError ? .errorColor : Color.primaryTextFieldColorEnabled
                    )
                    .padding(.leading, 16)
                
                Spacer()
                
                Button {
                    action()
                } label: {
                    Text(imageUploaded ? "Change" : "Upload")
                        .customFont(
                            .semiBold_600,
                            size: 16,
                            color: shouldShowError ? .errorColor : .secondaryButtonColorNormal
                        )
                }
                .padding(.trailing, 16)
            }
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(
                        shouldShowError ? .errorColor : Color.primaryTextFieldColorEnabled,
                        lineWidth: 1
                    )
            )
            
            if shouldShowError {
                Text("Photo is required")
                    .customFont(.regular_400, size: 12, color: shouldShowError ? .errorColor : Color.primaryTextFieldColorEnabled)
                    .padding(.leading, 16)
            }
        }
    }
}
