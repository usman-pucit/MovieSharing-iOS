//
//  MovieDetailViewModelBuilder.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 30/06/2021.
//

import Foundation
import UIKit.UIImage
import Combine

struct MovieDetailViewModelBuilder {
    static func prepareViewModel(movie: DetailItems)-> MovieDetailViewModel{
        return MovieDetailViewModel(title: movie.snippet.title, genre: movie.snippet.tags?.joined(separator: ", ") ?? "", viewers: "", rating: "", description: movie.snippet.description, posterImage: URL(string: movie.snippet.thumbnails.high?.url ?? ""), thumnailImage: URL(string: movie.snippet.thumbnails.high?.url ?? ""))
    }
}
