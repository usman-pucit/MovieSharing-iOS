//
//  MovieListViewCell.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 30/06/2021.
//

import UIKit
import Combine
import Foundation

// MARK: - MovieListViewCell
class MovieListViewCell: UITableViewCell {
    
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
        mainView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
    }
}
