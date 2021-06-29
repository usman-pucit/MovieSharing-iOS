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
    func request(_ request: Request) -> AnyPublisher<Result<[MoviesModel], APIError>, Never>
//    func fetchMovieDetails(_ request: Request) -> AnyPublisher<Result<MoviesModel, APIError>, Never>
    func downloadImage(_ poster: String, size: PosterSize) -> AnyPublisher<UIImage?, Never>
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
    func request(_ request: Request) -> AnyPublisher<Result<[MoviesModel], APIError>, Never> {
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
    
    /**
        Download image request with background schedular
     */
    func downloadImage(_ poster: String, size: PosterSize) -> AnyPublisher<UIImage?, Never> {
        return Deferred { return Just(poster) }
        .flatMap({[unowned self] poster -> AnyPublisher<UIImage?, Never> in
            let url = size.url.appendingPathComponent(poster)
            return self.apiClient.downloadImage(from: url)
        })
        .subscribe(on: Scheduler.backgroundWorkScheduler)
        .receive(on: Scheduler.mainScheduler)
        .share()
        .eraseToAnyPublisher()
    }
}
