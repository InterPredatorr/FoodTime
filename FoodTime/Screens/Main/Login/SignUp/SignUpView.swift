//
//  SignUpView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    var config: LoginConfig.SignUp {
        SettingsManager.shared.screens.login.signUp
    }
    
    var body: some View {
        contentView
    }
}

extension SignUpView {
    var contentView: some View {
        VStack(alignment: .leading, spacing: 30) {
            ContentHeaderView(title: config.title.localized, height: 30)
            ElevatedCard(requestState: viewModel.requestStates.register) {
                VStack(alignment: .leading) {
                    Text(config.description.localized)
                        .foregroundColor(.textPrimary)
                    Spacer().frame(height: 10)
                    TextFieldView(text: $viewModel.signUpInfo.fullName,
                                  config: config.fields.fullname, height: 40)
                    TextFieldView(text: $viewModel.signUpInfo.emailAddress,
                                  config: config.fields.email, height: 40)
                    TextFieldView(text: $viewModel.signUpInfo.phoneNumber,
                                  config: config.fields.phoneNumber, height: 40)
                    TextFieldView(text: $viewModel.signUpInfo.password,
                                  config: config.fields.password,
                                  isSecure: true, height: 40)
                    if #available(iOS 16, *) {
                        HyperlinkViewSwiftUI()
                    } else {
                        HyperlinkView()
                            .frame(height: 50)
                    }
                    registerButton
                    bottomText
                }
            }
            Spacer()
        }
        .rootViewSetup()
    }
    
    
    var registerButton: some View {
        StateableButtonView(title: LocalizedStrings.register.localized, buttonColor: .mainColor, buttonState: $viewModel.requestStates.register) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation { viewModel.requestStates.register = .ready }
            }
        }
    }
    
    var bottomText: some View {
        HStack {
            Text(config.haveAccountMessage.localized)
                .foregroundColor(.textPrimary)
            Button {
                withAnimation(.easeInOut) {
                    viewModel.currentScreen = .signIn
                }
            } label: {
                Text(LocalizedStrings.login.localized)
                    .fontWeight(.bold)
                    .foregroundColor(.mainColor)
            }
            Spacer()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: .init())
    }
}
