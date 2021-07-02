//
//  GradientView.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 02/07/2021.
//

import UIKit

extension UIView {
    func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(1).cgColor, UIColor.black.withAlphaComponent(0.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
