//
//  ChangePasswordView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 14.09.23.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @ObservedObject var viewModel: MyProfileViewModel
    @State private var requestState: ButtonState = .ready
    private let spacing: CGFloat = 30
    let config = SettingsManager.shared.screens.myProfile.changePassword
    
    var body: some View {
        contentView
    }
}

extension ChangePasswordView {
    var contentView: some View {
        VStack(spacing: spacing) {
            ContentHeaderView(title: config.title)
            ElevatedCard(requestState: requestState) {
                VStack(alignment: .leading, spacing: spacing) {
                    TextFieldView(text: $viewModel.currentPassword,
                                  config: config.fields.currentPassword)
                    TextFieldView(text: $viewModel.newPassword,
                                  config: config.fields.newPassword)
                    TextFieldView(text: $viewModel.confirmPassword,
                                  config: config.fields.confirmPassword)
                    StateableButtonView(title: config.buttonTitle.localized, buttonColor: .mainColor, buttonState: $requestState) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation { 
                                viewModel.returnToMain()
                                requestState = .ready
                            }
                        }
                    }
                    .fixedSize()
                }
            }
            Spacer()
        }
        .padding(.horizontal, Constants.screenPadding)
        .rootViewSetup()
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(viewModel: .init() {})
    }
}
