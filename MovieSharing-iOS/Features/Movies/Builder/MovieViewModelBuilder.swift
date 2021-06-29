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
    static func prepareViewModel(movie: MoviesModel, image: (String) -> AnyPublisher<UIImage?, Never>)-> MovieViewModel{
        return MovieViewModel(title: movie.title, image: image(movie.posterImage))
    }
}
