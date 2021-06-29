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
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!

    // MARK: - Properties
    private var cancellable: [AnyCancellable] = []
    
    // MARK: - Configure Cell
    func configure(with viewModel: MovieViewModel) {
        posterImage.layer.cornerRadius = 4
        posterImage.layer.masksToBounds = true
        titleLabel.text = viewModel.title
    }
}
