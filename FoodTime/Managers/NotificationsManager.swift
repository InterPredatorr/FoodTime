//
//  NotificationsManager.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 02.10.23.
//

import Foundation
import OneSignalFramework

class NotificationsManager {
    
    static func loginToOneSignal() {
        OneSignal.login(AccountManager.shared.myProfileInfo.fullname + "_id")
        OneSignal.User.addEmail(AccountManager.shared.myProfileInfo.email)
        OneSignal.User.addSms(AccountManager.shared.myProfileInfo.phoneNumber)
    }
    
    static func getOneSignalUserId()-> String {
        let playerId: String  = OneSignal.User.pushSubscription.id ?? ""
        return playerId
    }
}
