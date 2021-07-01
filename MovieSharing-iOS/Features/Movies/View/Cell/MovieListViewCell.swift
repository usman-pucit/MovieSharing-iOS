//
//  MovieListViewCell.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 30/06/2021.
//

import Combine
import Foundation
import Kingfisher
import UIKit

// MARK: - MovieListViewCell

class MovieListViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var mainView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImage: UIImageView!

    // MARK: - Properties

    private var cancellable: [AnyCancellable] = []

    // MARK: - Configure Cell

    func configure(with viewModel: MovieViewModel) {
        posterImage.layer.cornerRadius = 6
        posterImage.layer.masksToBounds = true
        titleLabel.text = viewModel.title
        posterImage.kf.setImage(with: viewModel.imagePoster)
        mainView.addShadow(offset: CGSize(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
    }
}
