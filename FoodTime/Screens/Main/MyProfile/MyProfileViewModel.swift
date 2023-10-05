//
//  MyProfileViewModel.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 14.09.23.
//

import Foundation
import OneSignalFramework

class MyProfileViewModel: ObservableObject {
    
    struct RequestStates {
        var updatePassword: ButtonState = .ready
        var logout: ButtonState = .ready
        var verifyPhone: ButtonState = .ready
        var requestOTP: ButtonState = .ready
    }
    
    @Published var requestStates = RequestStates()
    var contentRequestState: ButtonState {
        if (requestStates.requestOTP == .pending || requestStates.verifyPhone == .pending) {
            return .pending
        }
        return .ready
    }
    @Published var profileCurrentScreen: MyProfileScreen = .mainScreen
    @Published var phoneVerificationOTP = ""
    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var myProfileConfig: MyProfile = .init(fullname: "", email: "",
                                                      phoneNumber: "", isPhoneNumberVerified: false,
                                                      addressBook: [], password: "")
    
    
    let logout: () -> Void
    
    init(logout: @escaping () -> Void) {
        self.logout = logout
    }
    
    func updatePasswordTapped() {
        profileCurrentScreen = .updatePassword
    }
    
    func addressBookTapped() {
        profileCurrentScreen = .addressBook
    }
    
    func verifyPhoneTapped() {
        profileCurrentScreen = .verifyPhone
    }
    
    func logoutTapped() {
        logout()
        OneSignal.logout()
    }
    
    func returnToMain() {
        profileCurrentScreen = .mainScreen
    }
}
