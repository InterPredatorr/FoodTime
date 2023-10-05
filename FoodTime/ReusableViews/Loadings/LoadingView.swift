//
//  LoadingView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

struct LoadingView: View {
    
    var foregroundColor: Color? = nil
    var delay: Int = 2
    var scale: CGFloat = 0.5
    var length: CGFloat = 10
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<3) { i in
                DotView(delay: CGFloat(i * delay) / 10, scale: scale, length: length, speed: CGFloat(delay))
            }
        }
        .foregroundColor(foregroundColor ?? .mainGrayDark)
    }
}

struct DotView: View {
    @State var delay: CGFloat
    @State var scale: CGFloat
    let length: CGFloat
    let speed: CGFloat
    var body: some View {
        Circle()
            .frame(width: length, height: length)
            .scaleEffect(scale)
            .animation(Animation.easeInOut(duration: speed * 0.3).repeatForever().delay(delay))
            .onAppear {
                withAnimation { self.scale = 1 }
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
