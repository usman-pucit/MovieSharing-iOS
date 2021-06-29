//
//  MovieCollectionViewCell.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import UIKit
import Combine
import Foundation

// MARK: - MovieCollectionViewCell
class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var posterImage: UIImageView!

    // MARK: - Properties
    private var cancellable: [AnyCancellable] = []
    
    // MARK: - Configure Cell
    func configure(with viewModel: MovieViewModel) {
        titleLabel.text = viewModel.title
        self.backgroundColor = .randomColor()
    }
}
