//
//  AppDelegate.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import UIKit
import OneSignalFramework
import UserNotifications
import SwiftUI

@main
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    let basketManager = BasketManager()
    let viewHandler = ViewSelectionManager()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.configureUserNotifications()
        registerForRemoteNotification()
        OneSignal.initialize(Constants.appID, withLaunchOptions: launchOptions)
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let sessionRole = connectingSceneSession.role
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: sessionRole)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
    
    var containerView: some View {
        ContainerView()
            .environmentObject(basketManager)
            .environmentObject(viewHandler)
    }
}
