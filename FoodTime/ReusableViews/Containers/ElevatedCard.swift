//
//  ElevatedCard.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

struct ElevatedCard<Content: View>: View {
    
    var backgroundColor: Color?
    var padding: CGFloat? = nil
    let contentView: Content
    var requestState: ButtonState
    
    init(requestState: ButtonState? = nil, padding: CGFloat? = nil, backgroundColor: Color? = nil, contentView: () -> Content) {
        self.requestState = requestState ?? .ready
        self.padding = padding
        self.backgroundColor = backgroundColor
        self.contentView = contentView()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            contentView
            Spacer().frame(height: requestState == .ready ? 0 : 10)
            if requestState == .pending {
                InfiniteLoadingView()
            }
        }
        .padding([.top, .horizontal], padding ?? 16)
        .padding(.bottom, requestState == .pending ? 0 : ( padding ?? 16))
        .background(backgroundColor ?? .mainWhite)
        .cornerRadius(Constants.cornerRadius)
        .customShadow()
    }
}

struct ElevatedCard_Previews: PreviewProvider {
    static var previews: some View {
        ElevatedCard(requestState: .pending) { Text("hello") }
    }
}
