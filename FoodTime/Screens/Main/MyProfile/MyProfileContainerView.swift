//
//  MyProfileContainerView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 14.09.23.
//

import SwiftUI

struct MyProfileContainerView: View {
    
    @ObservedObject var viewModel: MyProfileViewModel
    
    var body: some View {
        switch viewModel.profileCurrentScreen {
        case .mainScreen:
            MyProfileView(viewModel: viewModel)
        case .addressBook:
            AddressBookView(viewModel: viewModel)
        case .updatePassword:
            ChangePasswordView(viewModel: viewModel)
        case .verifyPhone:
            VerifyPhoneView(viewModel: viewModel)
        }
    }
}

struct MyProfileContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileContainerView(viewModel: .init() {})
    }
}
