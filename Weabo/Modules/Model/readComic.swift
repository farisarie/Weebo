//
//  readComic.swift
//  ComicKid
//
//  Created by yoga arie on 11/11/22.
//

import Foundation

// MARK: - ReadComic
struct ReadComic: Codable {
    let data: Read
}

// MARK: - DataClass
struct Read: Codable {
    let imageUrls: [ImageURL]
    let nextURL: String
    let prevURL: String

    enum CodingKeys: String, CodingKey {
        case imageUrls = "image_urls"
        case nextURL = "next_url"
        case prevURL = "prev_url"
    }
}

// MARK: - ImageURL
struct ImageURL: Codable {
    let imageURL: String
    let imageIndex: Int

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case imageIndex = "image_index"
    }
}
