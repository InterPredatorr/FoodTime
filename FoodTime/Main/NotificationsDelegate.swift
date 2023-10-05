//
//  NotificationsDelegate.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 03.10.23.
//

import UIKit
import UserNotifications

extension AppDelegate {
    func registerForRemoteNotification() {
        let center  = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            if error == nil {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02x", $1)})
        print("Device push notification token - \(tokenString)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notification. Error \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("Recived: \(userInfo)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case Constants.RemoteActions.review:
            viewHandler.selectedView = .myOrders
            viewHandler.presentOrderReviewView = true
        case Constants.RemoteActions.ok:
            viewHandler.selectedView = .myOrders
            viewHandler.presentOrderReviewView = false
        default:
            break
        }
    }
    
    func configureUserNotifications() {
        let acceptAction = UNNotificationAction(identifier: "review_id", title: "Review", options: [.foreground])
        let rejectAction = UNNotificationAction(identifier: "ok_id", title: "OK", options: [.foreground])
        let category = UNNotificationCategory(identifier: "order", actions: [acceptAction,rejectAction],
                                              intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}
