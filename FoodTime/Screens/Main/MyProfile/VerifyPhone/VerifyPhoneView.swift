//
//  VerifyPhoneView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 14.09.23.
//

import SwiftUI

struct VerifyPhoneView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @ObservedObject var viewModel: MyProfileViewModel
    let config = SettingsManager.shared.screens.myProfile.verifyPhone
    var body: some View {
        contentView
    }
}

extension VerifyPhoneView {
    var contentView: some View {
        VStack(spacing: 30) {
            ContentHeaderView(title: config.title.localized)
            ElevatedCard(requestState: viewModel.contentRequestState) {
                VStack(alignment: .leading, spacing: 30) {
                    Group {
                        Text(config.description1.localized) +
                        Text("\(viewModel.myProfileConfig.phoneNumber)")
                            .fontWeight(.bold) +
                        Text(config.description2.localized)
                    }
                    .lineLimit(3)
                    .font(.system(size: 14))
                    .foregroundColor(.textPrimary)
                    TextFieldView(text: $viewModel.phoneVerificationOTP,
                                  config: config.fields.otp, height: 40)
                    HStack(spacing: 15) {
                        StateableButtonView(title: config.requestOTPTitle.localized, buttonColor: .mainColor, height: 40, buttonState: $viewModel.requestStates.requestOTP) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    viewModel.returnToMain()
                                    viewModel.requestStates.requestOTP = .ready
                                }
                            }
                        }
                        StateableButtonView(title: config.verifyTitle.localized, buttonColor: verifyButtonColor, height: 40,  buttonState: $viewModel.requestStates.verifyPhone) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    viewModel.returnToMain()
                                    viewModel.requestStates.verifyPhone = .ready
                                }
                            }
                        }
                        .disabled(viewModel.phoneVerificationOTP.isEmpty)
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, Constants.screenPadding)
        .rootViewSetup()
    }
    
    var verifyButtonColor: Color {
        viewModel.phoneVerificationOTP.isEmpty ? .mainGrayDark : .mainGreen
    }
}

struct VerifyPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyPhoneView(viewModel: .init() {})
    }
}
