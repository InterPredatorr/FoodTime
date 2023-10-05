//
//  SideMenu.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

struct SideMenu<Content: View>: View {
    
    var edgeTransition: AnyTransition = .move(edge: .leading)
    var presentingSideMenu: Bool
    var content: Content
    let tapped: () -> Void
    
    init(presentingSideMenu: Bool, content: () -> Content, tapped: @escaping () -> Void) {
        self.presentingSideMenu = presentingSideMenu
        self.content = content()
        self.tapped = tapped
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if presentingSideMenu {
                Color.textPrimary
                    .opacity(0.3)
                    .onTapGesture { tapped() }
                    .gesture(DragGesture(minimumDistance: 50, coordinateSpace: .local)
                        .onEnded { value in
                            if value.translation.width < -50 { tapped() }
                        })
                content
                    .transition(edgeTransition)
                    .background(Color.mainClear)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .animation(.easeInOut, value: presentingSideMenu)
    }
}
