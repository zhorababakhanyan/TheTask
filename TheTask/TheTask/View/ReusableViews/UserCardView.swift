//
//  UserCardView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 29/04/2025.
//

import SwiftUI

struct UserCardView: View {
    var user: User?
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            getUserImage()
            userInfoView()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

//MARK: - User Image
extension UserCardView {
    /// This function returns a view displaying the user's image.
    /// It checks if the `user?.photo` URL exists and loads the image asynchronously.
    /// If no URL is available, a default placeholder image is shown.
    /// - Returns: A `View` displaying either the user's image (if available) or a placeholder image.
    func getUserImage() -> some View {
        if let userImageURL = user?.photo, let url = URL(string: userImageURL) {
            return AnyView(
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image("UserImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .clipShape(Circle())
                .frame(width: 50, height: 50)
                .padding(.top, 4)
            )
        } else {
            return AnyView(
                Image("UserImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    .padding(.top, 4)
            )
        }
    }
}

// MARK: - UserInfoView
extension UserCardView {
    /// This function generates a user information view with the user's name, position, email, and phone number.
    /// It provides fallback text in case the user data is missing.
    /// - Parameters `user` The user whose information is being displayed. This is an optional property of type `User?`.
    /// - Returns A `VStack` view containing the user's name, position, email, and formatted phone number.
    func userInfoView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(user?.name ?? "User Name is Missing")
                .customFont(.regular_400, size: 18, color: .primaryTextColor)
                .multilineTextAlignment(.leading)

            Text(user?.position ?? "User Position is Missing")
                .customFont(.regular_400, size: 14, color: .secondaryTextColor)

            Text(user?.email ?? "User Email is Missing")
                .customFont(.regular_400, size: 14, color: .primaryTextColor)
                .lineLimit(1)
                .padding(.top, 4)
            Text(user?.phone.formattedPhoneNumber() ?? "User Phone Number is Missing")
                .customFont(.regular_400, size: 14, color: .primaryTextColor)
        }
    }
}
