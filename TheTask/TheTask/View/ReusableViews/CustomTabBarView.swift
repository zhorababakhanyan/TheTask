//
//  CustomTabView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 28/04/2025.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: Int
    let tabItems: [TabItem]
    
    var body: some View {
        ZStack {
            Color.primaryTabBarBackgroundColor
                .ignoresSafeArea(.all)
            self.getTabBarView()
        }
        .frame(height: 56)
    }
}

// MARK: - TabBar View
extension CustomTabBarView {
    /// Builds the horizontal stack view containing all tab bar items.
    ///
    /// - Returns: A `HStack` view displaying all tab buttons.
    func getTabBarView() -> some View {
        HStack(spacing: 0) {
            ForEach(0..<tabItems.count, id: \.self) { index in
                Button(action: {
                    withAnimation {
                        selectedTab = index
                    }
                }) {
                    self.getTabBarItemView(index: index)
                }
            }
        }
    }
}

// MARK: - TabBar Item View
extension CustomTabBarView {
    /// Builds the view for a single tab bar item.
    ///
    /// - Parameter index: The index of the tab item to display.
    /// - Returns: A `HStack` containing an icon and a title for the tab.
    func getTabBarItemView(index: Int) -> some View {
        HStack {
            Image(tabItems[index].icon)
                .renderingMode(.template)
                .foregroundColor(selectedTab == index ? .secondaryButtonColorNormal : .secondaryButtonColorDisabled)
            
            Text(tabItems[index].title)
                .customFont(.semiBold_600, size: 16,
                            color: selectedTab == index ? .secondaryButtonColorNormal : .secondaryButtonColorDisabled)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 10)
    }
}
