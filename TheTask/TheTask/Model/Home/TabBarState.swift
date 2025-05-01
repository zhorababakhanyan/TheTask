//
//  TabBarState.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 28/04/2025.
//

import Foundation

// MARK: - TabItem
/// A model representing a single tab in the application's tab bar.
///
/// - Properties:
///   - tab: An enum value of type `Tab` representing the destination or tab identifier.
///   - icon: The name of the icon asset used for the tab.
///   - title: The display title shown under the tab icon.
struct TabItem {
    let tab: Tab
    let icon: String
    let title: String
    
    static let allItems: [TabItem] = [
        TabItem(tab: .home , icon: "UsersIcon", title: "Users"),
        TabItem(tab: .signUp, icon: "SignUpIcon", title: "Sign Up")
    ]
}
