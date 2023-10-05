//
//  RoundedView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 12.09.23.
//

import SwiftUI

struct RoundedView<Content: View>: View {
    
    let content: Content
    var backgroundColor: Color
    var cornerRadius: CGFloat = 10
    var padding: CGFloat = 5
    
    init(backgroundColor: Color = .mainColor, content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(.all, padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
            )
    }
}

struct CircleView<Content: View>: View {
    
    @State private var size: CGSize = .zero
    let content: Content
    let padding: CGFloat
    
    init(padding: CGFloat = 1, content: () -> Content) {
        self.padding = padding
        self.content = content()
    }
    
    var lenght: CGFloat {
        max(size.width, size.height)
    }
    
    var body: some View {
        content
            .saveSize(in: $size)
            .frame(width: 20, height: 20)
            .padding(padding)
            .background(Color.mainGreen)
            .cornerRadius(lenght / 2 + padding)
    }
    
}

struct RoundedView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedView {
            HStack(spacing: 2) {
                Image(systemName: "star.fill")
                    .foregroundColor(.mainYellow)
                Text("4.5")
                    .foregroundColor(.mainWhite)
                    .font(.system(size: 20, weight: .bold))
            }
        }
    }
}
