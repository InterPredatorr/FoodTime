//
//  LoginViewComponents.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

struct LoginErrorView: View {
    
    @Binding var errors: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(LocalizedStrings.pleaseCheck)
                .foregroundColor(.textPrimary)
            ForEach(errors, id: \.count) { error in
                HStack {
                    Circle()
                        .frame(width: 5, height: 5)
                    Text(error.localized)
                        .foregroundColor(.textPrimary)
                        .font(.system(size: 14))
                        .minimumScaleFactor(0.8)
                        .lineLimit(2)
                    Spacer()
                }
                .foregroundColor(.mainColor)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 3)
        .background(Color.red.opacity(0.05))
        .background(Color.white)
        .cornerRadius(6)
        .shadow(color: .red.opacity(0.3), radius: 2, x: 0, y: 5)
    }
}

struct LoginOtherOptionsView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @State private var requestState: ButtonState = .ready
    
    var body: some View {
        VStack(spacing: 10) {
            LoginOptionButtonView(title: LocalizedStrings.googleTitle, imageName: LoginOptionType.google.rawValue, type: .google) {
                viewModel.signInWithGoogle()
            }
            LoginOptionButtonView(title: LocalizedStrings.facebookTitle, imageName: LoginOptionType.facebook.rawValue,
                                  type: .facebook, textColor: .white, backgroundColor: .facebookBackground) {
                viewModel.loginWithFacebook()
            }
            LoginOptionButtonView(title: LocalizedStrings.appleTitle, imageName: LoginOptionType.apple.rawValue, type: .apple) {
                viewModel.loginWithApple()
            }
        }
        .padding(Constants.screenPadding / 2)
    }
    
    
}

struct LoginOptionButtonView: View {
    
    let title: String
    let imageName: String
    let type: LoginOptionType
    var textColor: Color = .textPrimary
    var backgroundColor: Color = .mainWhite
    let buttonTapped: () -> Void
    
    var body: some View {
        Button {
            buttonTapped()
        } label: {
            ElevatedCard(backgroundColor: background) {
                HStack {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    Text(title.localized)
                        .font(.system(size: type == .google ? 14 : 16))
                    Spacer()
                }
                .foregroundColor(textColor)
                .frame(height: type == .google ? 15 : 25)
            }
        }
        .padding(.horizontal, padding(type: type))
    }
    
    var background: Color? {
        return type == .facebook ? backgroundColor : nil
    }
    
    func padding(type: LoginOptionType) -> CGFloat {
        return type == .google ? 30 : 0
    }
}

//struct HyperlinkView: View {
//    
//    let text: String
//    
//    var body: some View {
//        Text(text.localized)
//            .lineLimit(2)
//            .font(.system(size: 14))
//            .minimumScaleFactor(0.8)
//            .fixedSize(h: false)
//            .foregroundColor(.textPrimary)
//    }
//}
