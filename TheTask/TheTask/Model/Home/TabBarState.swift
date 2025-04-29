//
//  TabBarState.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 28/04/2025.
//

import Foundation

struct TabItem {
    let icon: String
    let title: String
    
    static let allItems: [TabItem] = [
        TabItem(icon: "UsersIcon", title: "Users"),
        TabItem(icon: "SignUpIcon", title: "Sign Up")
    ]
}
