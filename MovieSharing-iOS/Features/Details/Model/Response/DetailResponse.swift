/*
 Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

 */

import Foundation

struct DetailItems: Codable {
    let kind: String?
    let etag: String?
    let id: String?
    let snippet: DetailSnippet
}

struct DetailSnippet: Codable {
    let publishedAt: String?
    let channelId: String?
    let title: String
    let description: String
    let thumbnails: DetailThumbnails
    let channelTitle: String?
    let tags: [String]?
    let categoryId: String?
    let liveBroadcastContent: String?
    let defaultAudioLanguage: String?
}

struct DetailThumbnails: Codable {
    let `default`: Default?
    let medium: Medium?
    let high: High?
    let standard: Standard?
    let maxres: Maxres?

    enum CodingKeys: String, CodingKey {
        case `default`
        case medium
        case high
        case standard
        case maxres
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        `default` = try values.decodeIfPresent(Default.self, forKey: .default)
        medium = try values.decodeIfPresent(Medium.self, forKey: .medium)
        high = try values.decodeIfPresent(High.self, forKey: .high)
        standard = try values.decodeIfPresent(Standard.self, forKey: .standard)
        maxres = try values.decodeIfPresent(Maxres.self, forKey: .maxres)
    }
}

struct Maxres: Codable {
    let url: String
    let width: Int?
    let height: Int?
}

struct Standard: Codable {
    let url: String
    let width: Int?
    let height: Int?
}
