//
//  MovieCollectionViewCell.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import UIKit
import Combine
import Foundation
import Kingfisher

protocol ItemSelected{
    func didItemGetSelected(movie: MovieViewModel)
}

// MARK: - MovieCollectionViewCell
class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!

    // MARK: - Properties
    
    private var movie: MovieViewModel!
    var delegate: ItemSelected?
    
    // MARK: - Configure Cell
    func configure(with viewModel: MovieViewModel) {
        movie = viewModel
        posterImage.layer.cornerRadius = 6
        posterImage.layer.masksToBounds = true
        titleLabel.text = viewModel.title
        posterImage.kf.setImage(with: viewModel.imagePoster)
        mainView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
    }
    
    @IBAction func cellTapped(_ sender: UIButton){
        delegate?.didItemGetSelected(movie: movie)
    }
}
