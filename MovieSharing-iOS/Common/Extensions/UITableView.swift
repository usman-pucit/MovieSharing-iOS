//
//  UITableView.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import UIKit
import Foundation

extension UITableView {
    func registerClass<T: UITableViewCell>(cellClass `class`: T.Type) {
        register(`class`, forCellReuseIdentifier: `class`.reuseIdentifier)
    }

    func registerNib<T: UITableViewCell>(cellClass `class`: T.Type){
        register(`class`.nib, forCellReuseIdentifier: `class`.reuseIdentifier)
    }
    func dequeueReusableCell<T: UITableViewCell>(withClass `class`: T.Type) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: `class`.reuseIdentifier) as? T else{
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
