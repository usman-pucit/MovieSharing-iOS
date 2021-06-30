//
//  MoviesResponseModel.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 30/06/2021.
//
//

import Foundation

struct MoviesResponseModel : Codable {
	let kind : String
	let etag : String
	let nextPageToken : String
	let regionCode : String
	let pageInfo : PageInfo
	let items : [MovieItems]
}
