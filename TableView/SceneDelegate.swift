//
//  SceneDelegate.swift
//  TableView
//
//  Created by Арайлым Сермагамбет on 08.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let controller =  UINavigationController(rootViewController: ViewController())
        controller.navigationBar.prefersLargeTitles = true
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}

