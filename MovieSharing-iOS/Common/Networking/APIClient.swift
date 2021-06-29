//
//  APIClient.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//  
//

import UIKit.UIImage
import Combine
import Foundation

enum APIError: Error {
    case networkError
    case unknown(String)
}

protocol APIClientType{
    @discardableResult
    func execute<T>(_ request: Request) -> AnyPublisher<Result<T, APIError>, Never> where T: Decodable
    func downloadImage(from url: URL) -> AnyPublisher<UIImage?, Never>
}

class APIClient: APIClientType{
    private let cache = ImageCacheManager()
    // MARK: - Function
    
    @discardableResult
    func execute<T>(_ request: Request) -> AnyPublisher<Result<T, APIError>, Never> where T : Decodable {
        guard let request = request.request else {
            return .just(.failure(.networkError))
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
        .map(\.data)
        .decode(type: T.self, decoder: JSONDecoder())
        .map { response -> Result<T, APIError> in
            return .success(response)
        }
        .catch ({ error -> AnyPublisher<Result<T, APIError>, Never> in
            return .just(.failure(APIError.unknown(error.localizedDescription)))
        })
        .eraseToAnyPublisher()
    }
    
    func downloadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache.image(for: url) {
            return .just(image)
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache.insertImage(image, for: url)
            })
            .print("Image loading \(url):")
            .eraseToAnyPublisher()
    }
}
