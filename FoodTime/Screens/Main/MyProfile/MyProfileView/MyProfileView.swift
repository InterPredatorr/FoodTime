//
//  MyProfileView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 13.09.23.
//

import SwiftUI

struct MyProfileView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @ObservedObject var viewModel: MyProfileViewModel
    @State var requestState: ButtonState = .ready
    let config = SettingsManager.shared.screens.myProfile
    var body: some View {
        contentView
    }
}

extension MyProfileView {
    var contentView: some View {
        VStack {
            ContentHeaderView(title: config.title)
            ElevatedCard(requestState: requestState) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        Image(Images.login)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.textPrimary)
                        TextFieldView(text: $viewModel.myProfileConfig.fullname,
                                      config: config.fields.fullname)
                        TextFieldView(text: $viewModel.myProfileConfig.email,
                                      config: config.fields.email)
                        HStack {
                            Text(config.fields.contactNumber.title.localized)
                                .font(.system(size: 16, weight: .semibold))
                            
                            if !AccountManager.shared.myProfileInfo.isPhoneNumberVerified {
                                Image(systemName: Images.xmark)
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.textPrimary)
                                Text(LocalizedStrings.verified)
                                    .font(.system(size: 16, weight: .bold))
                            }
                            Spacer()
                        }
                        .foregroundColor(.textPrimary)
                        HStack(spacing: 5) {
                            TextFieldView(text: $viewModel.myProfileConfig.phoneNumber, config: .init(title: ""))
                                .fixedSize(h: false)
                            ButtonView(title: config.buttons.verify.localized,
                                       buttonColor: .mainGreen, height: 40) {
                                withAnimation { viewModel.verifyPhoneTapped() }
                            }
                            .fixedSize(v: false)
                        }
                        HStack {
                            ButtonView(title: config.buttons.addressBook.localized,
                                       buttonColor: .mainGreen, fontSize: 16) {
                                withAnimation { viewModel.addressBookTapped() }
                            }
                            ButtonView(title: config.buttons.changePassword.localized, buttonColor: .mainGreen, fontSize: 16) {
                                withAnimation { viewModel.updatePasswordTapped() }
                            }
                        }
                        StateableButtonView(title: config.buttons.logout.localized,
                                            buttonColor: .mainColor, buttonState: $requestState) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    viewModel.logoutTapped()
                                    requestState = .ready
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, Constants.screenPadding)
        }
        .rootViewSetup()
    }
}
