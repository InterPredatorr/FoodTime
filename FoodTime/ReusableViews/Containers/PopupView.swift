//
//  PopupView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 23.09.23.
//

import SwiftUI

struct PopupView<Content: View>: View {
    
    let content: Content
    
    init(content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Color.textPrimary.opacity(0.5).frame(maxHeight: .infinity)
            content
            Color.textPrimary.opacity(0.5).frame(maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
