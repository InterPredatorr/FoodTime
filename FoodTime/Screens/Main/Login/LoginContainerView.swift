//
//  LoginContainerView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 12.09.23.
//

import SwiftUI

struct LoginContainerView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            switch viewModel.currentScreen {
            case .signIn:
                SignInView(viewModel: viewModel)
            case .singUp:
                SignUpView(viewModel: viewModel)
            case .forgot:
                ForgotPasswordView(viewModel: viewModel)
            }
        }
        .padding(.horizontal, viewModel.currentScreen == .signIn ? 0 : Constants.screenPadding)
        .rootViewSetup()
    }
}

struct LoginContainerView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContainerView(viewModel: .init())
    }
}
