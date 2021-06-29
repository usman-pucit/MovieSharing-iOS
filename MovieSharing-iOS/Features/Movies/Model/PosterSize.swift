//
//  PosterSize.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import Foundation

enum PosterSize {
    case small
    case original
    var url: URL {
        switch self {
        case .small: return Constants.smallImageUrl
        case .original: return Constants.originalImageUrl
        }
    }
}

