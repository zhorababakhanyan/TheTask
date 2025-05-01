//
//  PositionSelectionView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 30/04/2025.
//

import SwiftUI

struct PositionSelectionView: View {
    let position: Position
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 25){
            ZStack {
                Circle()
                    .fill(isSelected ? Color.secondaryButtonColorPressed : Color.primarySelectionViewColorNormal)
                Circle()
                    .fill(Color.primaryBackgroundColor)
                    .frame(width: isSelected ? 6 : 12, height: isSelected ? 6 : 12)
            }
            .frame(width: 14, height: 14)
            Text(position.name)
                .customFont(.regular_400, size: 16, color: .primaryTextColor)
        }
        .frame(height: 48)
    }
}


