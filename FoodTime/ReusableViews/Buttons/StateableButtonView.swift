//
//  StateableButtonView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 18.09.23.
//

import SwiftUI

struct StateableButtonView: View {
    
    let title: String
    let buttonColor: Color
    var foregroundColor: Color? = nil
    var height: CGFloat? = nil
    var fontSize: CGFloat? = nil
    @Binding var buttonState: ButtonState
    let buttonTapped: () -> Void
    @State private var buttonPressed = false
    
    var body: some View {
        Button {
            buttonState = .pending
            buttonTapped()
        } label: {
            HStack {
                Spacer()
                if buttonState == .pending {
                    LoadingView(foregroundColor: foregroundColor ?? .white)
                }
                Text(title.localized)
                    .lineLimit(1)
                    .font(.system(size: fontSize ?? 20))
                    .foregroundColor(foregroundColor ?? .white)
                    .minimumScaleFactor(0.6)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: height ?? 50)
        .background((buttonState == .pending || buttonState == .disabled) ? Color.mainGrayDark : buttonColor)
        .cornerRadius(Constants.cornerRadius)
        .scaleOnTap(scaleSize: 0.9)
        .disabled(buttonState == .pending || buttonState == .disabled)
    }
}

struct StateableButtonView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        @State var buttonState: ButtonState = .ready
        
        StateableButtonView(title: "Title", buttonColor: .mainGreen, buttonState: $buttonState, buttonTapped: { })
    }
}
