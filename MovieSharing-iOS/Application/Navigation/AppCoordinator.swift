//
//  AppCoordinator.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 01/07/2021.
//

import UIKit

// MARK: - Class

/// Class to manage application navigation.

final class AppCoordinator: Coordinator {
    // MARK: - Properties

    var navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Start coordination

    func start() {
        let vc = TabBarController.instantiate(fromAppStoryboard: .Main)
        navigationController.pushViewController(vc, animated: false)
    }
}
