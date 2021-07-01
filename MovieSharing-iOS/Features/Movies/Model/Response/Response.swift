//
//  Response.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 30/06/2021.
//
//

import Foundation

struct Default: Codable {
    let url: String
    let width: Int?
    let height: Int?
}

struct High: Codable {
    let url: String
    let width: Int?
    let height: Int?
}

struct Id: Codable {
    let kind: String?
    let videoId: String?
    let playlistId: String?
    let channelId: String?

    enum CodingKeys: String, CodingKey {
        case playlistId
        case kind
        case videoId
        case channelId
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        videoId = try values.decodeIfPresent(String.self, forKey: .videoId)
        playlistId = try values.decodeIfPresent(String.self, forKey: .playlistId)
        channelId = try values.decodeIfPresent(String.self, forKey: .channelId)
    }
}

struct MovieItems: Codable {
    let kind: String?
    let etag: String?
    let id: Id?
    let snippet: Snippet
}

struct Medium: Codable {
    let url: String
    let width: Int?
    let height: Int?
}

struct PageInfo: Codable {
    let totalResults: Int?
    let resultsPerPage: Int?
}

struct Snippet: Codable {
    let publishedAt: String?
    let channelId: String?
    let title: String
    let description: String?
    let thumbnails: Thumbnails
    let channelTitle: String?
    let liveBroadcastContent: String?
    let publishTime: String?
}

struct Thumbnails: Codable {
    let `default`: Default
    let medium: Medium
    let high: High
}
