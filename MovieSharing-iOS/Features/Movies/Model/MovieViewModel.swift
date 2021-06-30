//
//  MovieViewModel.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import Combine
import UIKit.UIImage
import Foundation

// Section
struct MovieSectionViewModel {
    let viewModels: [MovieViewModel]
}

// Row
struct MovieViewModel {
    let videoId: String
    let playlistId: String
    let title: String
    let imagePoster: URL
}
