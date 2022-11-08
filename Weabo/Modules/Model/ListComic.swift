//
//  GetComic.swift
//  KumparanTest
//
//  Created by yoga arie on 15/09/22.
//
import Foundation

// MARK: - GetComic
struct ListComic: Decodable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
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
