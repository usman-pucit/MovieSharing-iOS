//
//  MoviesUseCase.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//  
//

import UIKit.UIImage
import Combine
import Foundation

protocol MoviesUseCaseType {
    func request(_ request: Request) -> AnyPublisher<Result<MoviesResponseModel, APIError>, Never>
//    func fetchMovieDetails(_ request: Request) -> AnyPublisher<Result<MoviesModel, APIError>, Never>
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
        return apiClient
            .execute(request)
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    /**
        API request for fetching movie details
     */
//    func fetchMovieDetails(_ request: Request) -> AnyPublisher<Result<MoviesModel, APIError>, Never> {
//
//    }

}
