//
//  InfiniteLoadingView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 18.09.23.
//

import SwiftUI

private let height: CGFloat = 4
private let coverPercentage: CGFloat = 0.8
private let minOffset: CGFloat = -2
private let maxOffset = 1 / coverPercentage * abs(minOffset)

struct InfiniteLoadingView: View {
    
    @State private var offset = minOffset
    
    var body: some View {
        Rectangle()
            .foregroundColor(.background)
            .frame(height: height)
            .overlay(GeometryReader { geo in
                overlayRect(in: geo.frame(in: .local))
            })
    }
    
    private func overlayRect(in rect: CGRect) -> some View {
        let width = rect.width * coverPercentage
        return Rectangle()
            .foregroundColor(.mainColor)
            .frame(width: width)
            .offset(x: width * offset)
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    self.offset = maxOffset;
                }
            }
    }
}

struct InfiniteLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteLoadingView()
    }
}
