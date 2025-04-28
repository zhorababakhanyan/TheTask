//
//  TabViewModel.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 28/04/2025.
//

import SwiftUI

final class TabViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    
    let tabItems = TabItem.allItems
    
    var requestStage: RequestStage {
        switch selectedTab {
        case 0: return .getRequest
        default: return .postRequest
        }
    }
}
