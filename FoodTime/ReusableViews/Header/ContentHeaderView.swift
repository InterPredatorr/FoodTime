//
//  ContentHeaderView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

struct ContentHeaderView: View {
    
    let title: String
    var foregroundColor: Color? = nil
    var midRectangleColor: Color? = nil
    var rectangleColor: Color? = nil
    var height: CGFloat? = nil
    var fontSize: CGFloat? = nil
    
    var body: some View {
        HStack(spacing: 5) {
            sideView
            if title.isEmpty {
                Image(Images.mainIcon)
                    .resizable()
                    .frame(width: 120, height: 40)
                    .scaledToFit()
                    .foregroundColor(.textPrimary)
            } else {
                Text(title.localized)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .font(.system(size: fontSize ?? 25))
                    .fixedSize()
                    .foregroundColor(foregroundColor ?? .textPrimary)
            }
            sideView
        }
        .frame(height: height ?? 50)
    }
    
    var sideView: some View {
        VStack(spacing: 0) {
            rectangle
            (midRectangleColor ?? .mainClear)
                .frame(height: 5)
            rectangle
        }
    }
    
    var rectangle: some View {
        Rectangle()
            .fill(rectangleColor ?? .mainColorDark)
            .frame(height: 1)
    }
}


struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentHeaderView(title: "forgot_password_title".localized)
    }
}
