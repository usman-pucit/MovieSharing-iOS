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
        return MovieViewModel(videoId: movie.id.videoId, title: movie.snippet.title, description: movie.snippet.description ?? "", channelTitle: movie.snippet.channelTitle ?? "", imagePoster: URL(string: movie.snippet.thumbnails.medium.url)!)
    }
}
