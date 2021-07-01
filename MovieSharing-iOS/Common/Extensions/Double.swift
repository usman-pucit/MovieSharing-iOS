//
//  Double.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 01/07/2021.
//

import Foundation

extension Double {
    func splitIntoParts(decimalPlaces: Int) -> (leftPart: Int, rightPart: Int) {
        let number = self.round(to: 1)
        // convert to string and split on decimal point:
        let parts = String(number).components(separatedBy: ".")

        // extract left and right parts:
        let leftPart = Int(parts[0]) ?? 0
        let rightPart = Int(parts[1]) ?? 0

        return (leftPart, rightPart)
    }

    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
