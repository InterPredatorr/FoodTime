//
//  NavigationBarItemView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 16.09.23.
//

import SwiftUI

struct NavigationBarItemView<Content: View>: View {

    let content: Content
    let tapped: () -> Void
    var isSelected: Bool

    init(isSelected: Bool, content: () -> Content, tapped: @escaping () -> Void) {
        self.isSelected = isSelected
        self.content = content()
        self.tapped = tapped
    }
    
    var body: some View {
        content
            .foregroundColor(.textPrimary)
            .font(.system(size: 20, weight: .regular))
            .padding(.horizontal, 15)
            .frame(height: 40)
            .background(navBarItemBackground())
            .cornerRadius(10)
            .padding(.vertical, 10)
            .shadow(color: shadowColor(), radius: 0, x: 0, y: 3)
            .onTapGesture { tapped() }
            .animation(.easeInOut, value: isSelected)

    }
    
    func navBarItemBackground() -> Color {
        isSelected ? Color.background : .mainClear
    }
    
    func shadowColor() -> Color {
        isSelected ? Color.mainColor : .mainClear
    }
}
