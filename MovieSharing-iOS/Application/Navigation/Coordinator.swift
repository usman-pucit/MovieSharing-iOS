//
//  Coordinator.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 01/07/2021.
//

import UIKit

// MARK: - Protocol

/// Abstract functions for app navigation.
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
