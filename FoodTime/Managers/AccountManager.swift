//
//  AccountManager.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 23.09.23.
//

import Foundation

class AccountManager: ObservableObject {
    
    var myProfileInfo: MyProfile = .init(fullname: "Sevak",
                                         email: "sevak.tadevosyan.dev@gmail.com",
                                         phoneNumber: "+37494610421",
                                         isPhoneNumberVerified: false,
                                         addressBook: [.init(addressName: "A1",
                                                             address: "Domain 1, 530, Persiaran Ceria, Cyber 12, 63000 Cyberjaya, Selangor, Malaysia"),
                                                       .init(addressName: "He",
                                                             address: "Desa Kiara Condominium, Jln Damansara, Bukit Kiara, 60000 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur, Malaysia")],
                                         password: "foodtime")
    
    static let shared = AccountManager()
    private init() { }
    
    func deleteFromAddressBook(_ address: AddressInfo) {
        myProfileInfo.addressBook.removeAll(where: { $0.addressName == address.addressName })
    }
    
    func addNewAddress(_ address: AddressInfo) {
        myProfileInfo.addressBook.insert(address, at: 0)
        if address.isDefault {
            myProfileInfo.addressBook = myProfileInfo.addressBook.map {
                var tmp = $0
                tmp.isDefault = tmp.id == address.id
                return tmp
            }
        }
    }
    
    func updateSelectedAddress(_ address: AddressInfo) {
        myProfileInfo.addressBook = myProfileInfo.addressBook.map {
            var tmp = $0
            tmp.isSelected = address.id == tmp.id
            return tmp
        }
    }
}
