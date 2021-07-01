//
//  ActivityViewController.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 30/06/2021.
//

import UIKit

class ActivityViewController: UIViewController {
    // MARK: IBOutlets

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setTitle(title: String) {
        titleLabel.text = title
    }
}
