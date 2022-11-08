//
//  searchComic.swift
//  ComicKid
//
//  Created by yoga arie on 16/09/22.
//

import Foundation

struct SearchComic: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let comics: [Comic]
}

// MARK: - Comic
struct Comic: Codable {
    let title, typeComic, chapter, rating: String
    let comicURL: String
    let thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case title
        case typeComic = "type_comic"
        case chapter, rating
        case comicURL = "comic_url"
        case thumbnailURL = "thumbnail_url"
    }
}
