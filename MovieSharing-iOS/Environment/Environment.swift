//
//  Environment.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import Foundation

/**
 Environment class to manage environment settings and api url's
 */

public enum Environment {
    // MARK: - Keys
    
    enum Keys {
        enum Plist {
            static let BASE_URL = "BASE_URL"
            static let API_KEY = "API_KEY"
        }
    }
    
    // MARK: - Plist
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    static let BASE_URL: URL = {
        guard let urlString = Environment.infoDictionary[Keys.Plist.BASE_URL] as? String, let baseURL = URL(string: urlString) else {
            fatalError("BASE_URL not found")
        }
        return baseURL
    }()
    
    static let API_KEY: String = {
        guard let key = Environment.infoDictionary[Keys.Plist.API_KEY] as? String else {
            fatalError("TMDB_API_KEY not found")
        }
        return key
    }()
}
