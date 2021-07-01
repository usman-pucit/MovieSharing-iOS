//
//  SceneDelegate.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let window = window else { return }

        let navController = UINavigationController()

        // Setting up application navigation
        coordinator = AppCoordinator(navigationController: navController)
        coordinator?.start()

        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}

