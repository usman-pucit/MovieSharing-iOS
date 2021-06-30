//
//  MovieViewModelBuilder.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import Foundation
import UIKit.UIImage
import Combine

struct MovieViewModelBuilder {
    static func prepareViewModel(movie: MovieItems, image: (String) -> AnyPublisher<UIImage?, Never>)-> MovieViewModel{
        return MovieViewModel(title: movie.snippet.title, image: image(movie.snippet.thumbnails.high.url))
    }
}
