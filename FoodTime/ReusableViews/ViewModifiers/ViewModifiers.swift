//
//  ViewModifiers.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct SizeCalculator: ViewModifier {
    
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                }
            )
    }
}

struct ShadowViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .mainGrayDark.opacity(0.5), radius: 4, x: 2, y: 2)
    }
}

struct ScaleViewOnTap: ViewModifier {
    let scaleSize: CGFloat
    @State private var pressed = false
    func body(content: Content) -> some View {
        ZStack {
            content.simultaneousGesture(
                TapGesture().onEnded {
                    withAnimation {
                        pressed.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation {
                                pressed.toggle()
                            }
                        }
                    }
                    UNNotificationSound.defaultCriticalSound(withAudioVolume: 1)
                })
            .scaleEffect(pressed ? scaleSize : 1)
        }
        
    }
}

struct RootViewSetup: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(Color.background.edgesIgnoringSafeArea(.all))
    }
}

struct FixedSize: ViewModifier {
    
    var horizontal = true
    var vertical = true
    
    func body(content: Content) -> some View {
        content
            .fixedSize(horizontal: horizontal, vertical: vertical)
    }
}

extension View {
    func customShadow() -> some View {
        modifier(ShadowViewModifier())
    }
    func scaleOnTap(scaleSize: CGFloat) -> some View {
        modifier(ScaleViewOnTap(scaleSize: scaleSize))
    }
    func rootViewSetup() -> some View {
        modifier(RootViewSetup())
    }
    func fixedSize(h: Bool = true, v: Bool = true) -> some View {
        modifier(FixedSize(horizontal: h, vertical: v))
    }
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    func saveSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}
