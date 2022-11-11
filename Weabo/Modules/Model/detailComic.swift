import Foundation

// MARK: - DetailComic
struct DetailComic: Codable {
    let data: DetailClass
}

// MARK: - DataClass
struct DetailClass: Codable {
    let title, dataDescription, rating: String
    let chapterList: [ChapterList]

    enum CodingKeys: String, CodingKey {
        case title
        case dataDescription = "description"
        case rating
        case chapterList = "chapter_list"
    }
}

// MARK: - ChapterList
struct ChapterList: Codable {
    let chapterURL: String
    let chapterNum, chapterDate: String

    enum CodingKeys: String, CodingKey {
        case chapterURL = "chapter_url"
        case chapterNum = "chapter_num"
        case chapterDate = "chapter_date"
    }
}
