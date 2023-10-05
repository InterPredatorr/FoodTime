//
//  TitleView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 26.09.23.
//

import SwiftUI

struct TitleView: View {
    
    let title: String
    var alignment: Alignment = .leading
    var color: Color = .mainColor
    var fontSize = 24.0
    
    var body: some View {
        Text(title.localized)
            .foregroundColor(color)
            .frame(maxWidth: .infinity, alignment: alignment)
            .font(.system(size: fontSize, weight: .semibold))
            .minimumScaleFactor(0.8)
    }
}

//#Preview {
//    TitleView()
//}
