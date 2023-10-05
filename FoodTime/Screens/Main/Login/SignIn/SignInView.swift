//
//  SignInView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    let config = SettingsManager.shared.screens.login.signIn
    var body: some View {
        contentView
    }
}

extension SignInView {
    var contentView: some  View {
        VStack(spacing: 5) {
            ContentHeaderView(title: config.title.localized, height: 30)
            ScrollView(showsIndicators: false) {
                SignInContentView(viewModel: viewModel)
                Spacer()
            }
        }
        .rootViewSetup()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: .init())
    }
}
