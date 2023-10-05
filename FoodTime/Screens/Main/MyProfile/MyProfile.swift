//
//  MyProfile.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 13.09.23.
//

import Foundation


struct MyProfile {
    var fullname: String
    var email: String
    var phoneNumber: String
    var isPhoneNumberVerified: Bool
    var addressBook: [AddressInfo]
    var password: String
}

struct AddressInfo: Identifiable {
    var id = UUID()
    var isDefault = false
    var isSelected = false
    var addressName: String
    var floor = ""
    var address: String
}

enum MyProfileScreen {
    case mainScreen
    case updatePassword
    case verifyPhone
    case addressBook
}
