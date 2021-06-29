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
    let uuid = UUID()
    let viewModels: [MovieViewModel]
}

extension MovieSectionViewModel: Hashable {
    static func == (lhs: MovieSectionViewModel, rhs: MovieSectionViewModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

// Row
struct MovieViewModel {
    let uuid = UUID()
    let title: String
    let image: AnyPublisher<UIImage?, Never>?
}

extension MovieViewModel: Hashable {
    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
