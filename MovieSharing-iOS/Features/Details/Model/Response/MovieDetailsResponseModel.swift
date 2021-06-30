//
//  MovieDetailsResponseModel.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 30/06/2021.
//
//

import Foundation
struct MovieDetailsResponseModel : Codable {
	let kind : String?
	let etag : String?
	let items : [DetailItems]
}
