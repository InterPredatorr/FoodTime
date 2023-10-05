//
//  SceneDelegate.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import UIKit
import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {
            
    var window: UIWindow?

    let navigationController = UINavigationController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        setupView()
        _ = NetworkCheck()
    }
    
    private func setupView() {
        
        let viewWithCoordinator = (UIApplication.shared.delegate as! AppDelegate).containerView
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        window?.rootViewController = navigationController
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
    

    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
      
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
      
    }
}
