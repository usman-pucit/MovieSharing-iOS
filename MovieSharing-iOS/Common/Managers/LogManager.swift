//
//  LogManager.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 01/07/2021.
//

import Foundation

let log = LogManager()

// Logs manager for printing logs

struct LogManager {
    func printLog(_ object: Any...) {
        print("\n******** 📍📍 START 📍📍 ********\n")
        print("\(object)")
        print("\n******** 📍📍 END 📍📍 ********\n")
    }
}
