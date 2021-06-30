//
//  APIClient.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//
//

import Combine
import Foundation
import UIKit.UIImage

enum APIError: Error {
    case networkError
    case unknown(String)
}

protocol APIClientType {
    @discardableResult
    func execute<T>(_ request: Request) -> AnyPublisher<Result<T, APIError>, Never> where T: Decodable
}

class APIClient: APIClientType {
    // MARK: - Function

    @discardableResult
    func execute<T>(_ request: Request) -> AnyPublisher<Result<T, APIError>, Never> where T: Decodable {
        guard let request = request.request else {
            return .just(.failure(.networkError))
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .map { response -> Result<T, APIError> in
                .success(response)
            }
            .catch { error -> AnyPublisher<Result<T, APIError>, Never> in
                .just(.failure(APIError.unknown(error.localizedDescription)))
            }
            .eraseToAnyPublisher()
    }
}
