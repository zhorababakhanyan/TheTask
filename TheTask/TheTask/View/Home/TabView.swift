//
//  TabView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 28/04/2025.
//

import SwiftUI

struct TabView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        ZStack {
            Color.primaryBackgroundColor
                .ignoresSafeArea(.all)
            VStack(spacing: 0){
                HeaderView(stage: selectedTab == .home ? .getRequest : .postRequest)
                Group {
                    switch selectedTab {
                    case .home:
                        HomeView()
                    case .signUp:
                        SignUpView(selectedTab: $selectedTab)
                    }
                }
                CustomTabBarView(selectedTab: $selectedTab, tabItems: TabItem.allItems)
                    .frame(height: 56)
            }
        }
    }
}
