//
//  TabView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 28/04/2025.
//

import SwiftUI

struct TabView: View {
    @StateObject private var viewModel = TabViewModel()
    
    var body: some View {
        ZStack {
            Color.primaryBackgroundColor
                .ignoresSafeArea(.all)
            VStack {
                HeaderView(stage: viewModel.requestStage)
                Group {
                    switch viewModel.selectedTab {
                    case 0: HomeView()
                    default:
                        SignUpView()
                    }
                }
                CustomTabBarView(selectedTab: $viewModel.selectedTab, tabItems: viewModel.tabItems)
            }
        }
    }
}
