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
        posterImage.layer.cornerRadius = 6
        posterImage.layer.masksToBounds = true
        titleLabel.text = viewModel.title
        viewModel.image?.sink(receiveValue: { image in
            self.posterImage.image = image
        }).store(in: &cancellable)
        mainView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
    }
}
