//
//  MoviesUseCase.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//
//

import Combine
import Foundation
import UIKit.UIImage

protocol MoviesUseCaseType {
    func request(_ request: Request) -> AnyPublisher<Result<MoviesResponseModel, APIError>, Never>
    func movieDetails(_ request: Request) -> AnyPublisher<Result<MovieDetailsResponseModel, APIError>, Never>
}

class MoviesUseCase {
    // MARK: -  Properties

    var apiClient: APIClientType

    // MARK: - Initializer

    init(apiClient: APIClientType = APIClient()) {
        self.apiClient = apiClient
    }
}

// MARK: - Extension

extension MoviesUseCase: MoviesUseCaseType {
    /**
        API request for fetching movies list
     */
    func request(_ request: Request) -> AnyPublisher<Result<MoviesResponseModel, APIError>, Never> {
        log.printLog("/n URL: \(request.url) /n")
        log.printLog("/n PARAMS: \(request.parameters) /n")

        return apiClient
            .execute(request)
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }

    /**
        API request for fetching movie details
     */
    func movieDetails(_ request: Request) -> AnyPublisher<Result<MovieDetailsResponseModel, APIError>, Never> {
        log.printLog("/n URL: \(request.url) /n")
        log.printLog("/n PARAMS: \(request.parameters) /n")
        return apiClient
            .execute(request)
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
