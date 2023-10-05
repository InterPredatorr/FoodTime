//
//  LoginViewModel.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI
import Combine

enum LoginOptionType: String {
    case apple
    case facebook
    case google
}

struct LoginInfo {
    var email: String
    var password: String
}

struct SignUpInfo {
    var fullName: String
    var emailAddress: String
    var phoneNumber: String
    var password: String
}

enum LoginScreen {
    case signIn
    case singUp
    case forgot
}

class LoginViewModel: ObservableObject {
    
    struct RequestStates {
        var login: ButtonState = .ready
        var sendResetPassword: ButtonState = .ready
        var register: ButtonState = .ready
    }
            
    @Published var requestStates = RequestStates()
    @Published var currentScreen: LoginScreen = .signIn
    @Published var forgottenPasswordEmail = ""
    @Published var loginErrors: [String] = []
    @Published var loginInfo: LoginInfo = .init(email: "", password: "")
    @Published var signUpInfo: SignUpInfo = .init(fullName: "", emailAddress: "", phoneNumber: "", password: "")
    
    func signInWithGoogle() {
        
    }
    
    func loginWithFacebook() {
        
    }
    
    func loginWithApple() {
        
    }
}
