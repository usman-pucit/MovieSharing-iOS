//
//  Constants.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import Foundation

struct Constants {
    // Movies constants
    struct Movies{
        static let title = "Movies"
        static let headerTitle = "Category"
    }
    // Movie details constants
    struct Details {
        static let title = "Movie title"
        static let loadingMessage = "Loading details"
    }
    
    // Favourites constants
    struct Favourites {
        static let title = "Favourites"
        static let search = "Search"
        static let cancel = "Cancel"
    }
    // Favourites constants 
    struct Settings {
        static let title = "Settings"
    }
    // Icons/Assets constants
    struct Icons{
        static let favoritesLight = "favorites_light"
        static let favoriteDisabled = "favorites_disabled"
        static let mic = "mic.fill"
    }
    // Error constants
    struct Error {
        static let errorTitle = "Error"
        static let generalErrorMessage = "Error..."
        static let noResults = "No results"
    }
}
