//
//  ModalPopupView2.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 25.09.23.
//

import SwiftUI

struct ModalPopupView2: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    let config: ModalPopupType.ModalConfig2
    
    var body: some View {
        ElevatedCard {
            VStack(spacing: 20) {
                errorTitle
                Divider()
                description
                Divider()
                bottomButton
            }
        }
        .padding(.horizontal, Constants.screenPadding)
        .background(Color.textPrimary.opacity(0.5))
    }
    
    var errorTitle: some View {
        HStack {
            Text(config.title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Button {
                withAnimation {
                    viewHandler.presentingPopupView.toggle()
                }
            } label: {
                Image(systemName: Images.xmark)
                    .resizable()
                    .font(Font.title.weight(.heavy))
                    .frame(width: 15, height: 15)
            }
        }
        .foregroundColor(Color.textPrimary)
    }
    
    var description: some View {
        Text(config.description)
            .font(.system(size: 16))
            .foregroundColor(Color.textPrimary)
            .multilineTextAlignment(.leading)
    }
    
    var bottomButton: some View {
        HStack {
            ButtonView(title: config.leftButtonTitle, buttonColor: .mainGreen) {
                withAnimation {
                    viewHandler.presentingPopupView.toggle()
                    config.leftButtonCompletion()
                }
            }
            .fixedSize()
            Spacer()
            ButtonView(title: config.rightButtonTitle, buttonColor: .mainColor) {
                withAnimation { 
                    viewHandler.presentingPopupView.toggle()
                    config.rightButtonCompletion()
                }
            }
            .fixedSize()
        }
    }
}

