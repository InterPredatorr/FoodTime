//
//  ButtonView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

struct ButtonView: View {
    
    let title: String
    let buttonColor: Color
    var foregroundColor: Color? = nil
    var height: CGFloat? = nil
    var fontSize: CGFloat? = nil
    let buttonTapped: () -> Void
    @State private var buttonPressed = false
    
    var body: some View {
        Button {
            buttonTapped()
        } label: {
            HStack {
                Spacer()
                Text(title.localized)
                    .lineLimit(1)
                    .font(.system(size: fontSize ?? 20))
                    .foregroundColor(foregroundColor ?? .white)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: height ?? 50)
        .background(buttonColor)
        .cornerRadius(Constants.cornerRadius)
        .scaleOnTap(scaleSize: 0.9)
        .disabled(buttonPressed)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Title", buttonColor: .mainGreen, buttonTapped: { })
    }
}
