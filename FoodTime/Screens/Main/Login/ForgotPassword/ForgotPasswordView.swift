//
//  ForgotPasswordView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var config: LoginConfig.ForgotPassword {
        SettingsManager.shared.screens.login.forgotPassword
    }
    
    var body: some View {
        contentView
    }
}

extension ForgotPasswordView {
    var contentView: some View {
        VStack(spacing: 5) {
            ContentHeaderView(title: config.title.localized, height: 30)
            ForgotPasswordContentView(viewModel: viewModel)
            Spacer()
        }
        .rootViewSetup()
    }
}

struct ForgotPasswordContentView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var config: LoginConfig.ForgotPassword {
        SettingsManager.shared.screens.login.forgotPassword
    }
    
    var body: some View {
        contentView
    }
}

extension ForgotPasswordContentView {
    
    var contentView: some View {
        ElevatedCard(requestState: viewModel.requestStates.sendResetPassword) {
            VStack(alignment: .leading, spacing: 30) {
                TextFieldView(text: $viewModel.forgottenPasswordEmail,
                              config: config.fields.email,
                              height: 40)
                sendResetPasswordButton
                if !viewModel.loginErrors.isEmpty {
                    LoginErrorView(errors: $viewModel.loginErrors)
                }
            }
        }
        .padding(.all, 5)
    }
    
    var sendResetPasswordButton: some View {
        HStack {
            StateableButtonView(title: config.buttonTitle.localized, buttonColor: .mainGreen, buttonState: $viewModel.requestStates.sendResetPassword) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        viewModel.requestStates.sendResetPassword = .ready
                        viewModel.currentScreen = .signIn
                    }
                }
            }
            .fixedSize()
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(viewModel: .init())
    }
}
