//
//  MovieHeaderViewCell.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 30/06/2021.
//

import UIKit

class MovieHeaderViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!

    func configure(_ title: String) {
        titleLabel.text = title
    }
}
