//
//  MoviesCoordinator.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 01/07/2021.
//

import UIKit

final class MoviesCoordinator{
    // MARK: - Properties

    var navigationController: UINavigationController?

    // MARK: - Initializer

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    // MARK: - Start coordination

    func start(_ movie: MovieViewModel) {
        let vc = MovieDetailsViewController.instantiate(fromAppStoryboard: .Main)
        vc.movie = movie
        navigationController?.pushViewController(vc, animated: true)
    }
}
