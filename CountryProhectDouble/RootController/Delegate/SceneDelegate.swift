//
//  SceneDelegate.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 23.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let WindowsScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = TabBarController()
        
        window = UIWindow(windowScene: WindowsScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

