//
//  SignInContentView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 20.09.23.
//

import SwiftUI

struct SignInContentView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @ObservedObject var viewModel: LoginViewModel
    
    var config: LoginConfig.SignIn {
        SettingsManager.shared.screens.login.signIn
    }
    
    var body: some View {
        contentView
    }
}

extension SignInContentView {
    var contentView: some View {
        ElevatedCard(requestState: viewModel.requestStates.login) {
            VStack(alignment: .leading, spacing: 12) {
                LoginOtherOptionsView(viewModel: viewModel)
                Divider()
                subtitle
                TextFieldView(text: $viewModel.loginInfo.email,
                              config: config.fields.email, height: 40)
                TextFieldView(text: $viewModel.loginInfo.password,
                              config: config.fields.password,
                              isSecure: true, height: 40)
                forgotPassword
                if #available(iOS 16, *) {
                    HyperlinkViewSwiftUI()
                } else {
                    HyperlinkView()
                        .frame(height: 50)
                }
                loginButton
                if !viewModel.loginErrors.isEmpty {
                    LoginErrorView(errors: $viewModel.loginErrors)
                }
                createAccountButton
            }
        }
        .padding(.all, Constants.screenPadding)
    }
}

extension SignInContentView {
    var forgotPassword: some View {
        HStack {
            Button {
                withAnimation(.easeInOut) {
                    viewModel.currentScreen = .forgot
                }
            } label: {
                Text(config.forgotPasswordTitle.localized)
                    .foregroundColor(.mainGreen)
                    .fontWeight(.bold)
            }
            Spacer()
        }
    }
    
    var loginButton: some View {
        StateableButtonView(title: config.loginTitle.localized, buttonColor: .mainGreen, buttonState: $viewModel.requestStates.login) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut) {
                    viewHandler.login()
                    viewModel.requestStates.login = .ready
                }
            }
        }
    }
    
    var createAccountButton: some View {
        HStack {
            Button {
                withAnimation(.easeInOut) {
                    viewModel.currentScreen = .singUp
                }
            } label: {
                Text(config.createAccountTitle.localized)
                    .foregroundColor(.mainColor)
                    .fontWeight(.bold)
            }
            Spacer()
        }
    }
    
    var subtitle: some View {
        TitleView(title: config.description.localized, alignment: .center, color: .textPrimary, fontSize: 14)
    }
}

struct SignInContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignInContentView(viewModel: .init())
    }
}
