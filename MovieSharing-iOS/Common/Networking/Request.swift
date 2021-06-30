//
//  EndPoint.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 05/02/2021.
//

import Combine
import Foundation

struct Request{
    let url: URL
    let parameters: [String: CustomStringConvertible]
    var request: URLRequest? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.queryItems = parameters.keys.map { key in
            URLQueryItem(name: key, value: parameters[key]?.description)
        }
        guard let url = components.url else {
            return nil
        }
        return URLRequest(url: url)
    }

    init(url: URL, parameters: [String: CustomStringConvertible] = [:]) {
        self.url = url
        self.parameters = parameters
    }
}

extension Request{
    static func movies() -> Request {
        let url = Environment.BASE_URL.appendingPathComponent("search")
        let parameters: [String : CustomStringConvertible] = [
            "key": Environment.API_KEY,
            "part": "snippet",
            "maxResults": "30"
            ]
        return Request(url: url, parameters: parameters)
    }
    
    static func movieDetails(_ videoId: String?, playlistId: String?) -> Request?{
        if let videoId = videoId {
            let url = Environment.BASE_URL.appendingPathComponent("videos")
            let parameters: [String : CustomStringConvertible] = [
                "key": Environment.API_KEY,
                "part": "snippet",
                "id": "\(videoId)"
                ]
            return Request(url: url, parameters: parameters)
        }else if let playlistId = playlistId{
            let url = Environment.BASE_URL.appendingPathComponent("playlists")
            let parameters: [String : CustomStringConvertible] = [
                "key": Environment.API_KEY,
                "part": "snippet",
                "id": "\(playlistId)"
                ]
            return Request(url: url, parameters: parameters)
        }else{
            return nil
        }
    }
}
