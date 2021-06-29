//
//  Reusable.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import UIKit
import Foundation

protocol NibProvidable {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibProvidable {
    static var nibName: String {
        return "\(self)"
    }
    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: nil)
    }
}

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

extension UITableViewCell: ReusableView, NibProvidable{}
extension UICollectionViewCell: ReusableView, NibProvidable{}
extension UITableViewHeaderFooterView: ReusableView, NibProvidable{}
