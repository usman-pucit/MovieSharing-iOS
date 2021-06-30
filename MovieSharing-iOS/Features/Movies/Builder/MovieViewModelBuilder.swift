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
    static func prepareViewModel(movie: MovieItems)-> MovieViewModel{
        return MovieViewModel(title: movie.snippet.title, imagePoster: URL(string: movie.snippet.thumbnails.high.url)!)
    }
}
