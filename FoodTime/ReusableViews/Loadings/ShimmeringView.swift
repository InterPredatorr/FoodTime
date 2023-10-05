//
//  ShimmeringView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 18.09.23.
//

import SwiftUI

public struct SkeletonGradientAnimationView: View {

    @State var offset: CGFloat = 0

    public var body: some View {
        ZStack {
            GeometryReader { reader in
                let largestSide = reader.size.width > reader.size.height ? reader.size.width : reader.size.height

                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .white.opacity(0), location: 0.333),
                        Gradient.Stop(color: .white, location: 0.5),
                        Gradient.Stop(color: .white.opacity(0), location: 0.666),
                    ],
                    startPoint: UnitPoint(x: 0, y: 0),
                    endPoint: UnitPoint(x: 1, y: 1)
                )
                    .frame(width: largestSide * 2.0, height: largestSide * 2, alignment: .leading)
                    .mask(
                        LinearGradient(colors: [.clear, .white, .white, .clear], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .blendMode(.overlay)
                    .offset(x: -largestSide * 2 + offset, y: reader.size.height * 0.5 - largestSide)
                    .onAppear {
                        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                            offset = largestSide * 3
                        }
                    }

            }
        }
    }
}

//Usage

struct SkeletonView: View {
    
    let cornerRadius: CGFloat
    
    var body: some View {
        SkeletonGradientAnimationView()
            .background(Color.mainGrayLight)
            .mask(RoundedRectangle(cornerRadius: cornerRadius))
    }
}


struct CircleSkeletonView: View {
    
    var body: some View {
        SkeletonGradientAnimationView()
            .background(Color.mainGrayLight)
            .mask(Circle())
    }
}

struct SkeletonGradientAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        SkeletonView(cornerRadius: 12)
    }
}
