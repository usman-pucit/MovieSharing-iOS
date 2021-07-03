//
//  MovieCollectionViewCell.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import Combine
import Foundation
import Kingfisher
import UIKit

protocol ItemSelected {
    func didItemGetSelected(movie: MovieViewModel)
}

// MARK: - MovieCollectionViewCell

class MovieCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets

    @IBOutlet var mainView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var shadowView: UIView!

    // MARK: - Properties

    private var movie: MovieViewModel!
    var delegate: ItemSelected?

    // MARK: - Configure Cell

    func configure(with viewModel: MovieViewModel) {
        movie = viewModel
        posterImage.layer.cornerRadius = 6
        posterImage.layer.masksToBounds = true
        titleLabel.text = viewModel.channelTitle
//        shadowView.addShadowAllAround(offset: CGSize(width: 0, height: 3), color: UIColor.black, radius: 6.0, opacity: 0.35)
        posterImage.kf.setImage(with: viewModel.imagePoster)
    }

    @IBAction func cellTapped(_ sender: UIButton) {
        delegate?.didItemGetSelected(movie: movie)
    }
}
