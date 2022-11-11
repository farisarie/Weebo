//
//  ComicProvider.swift
//  KumparanTest
//
//  Created by yoga arie on 15/09/22.
//

import Foundation
import Alamofire

class ComicProvider {
    static var shared: ComicProvider = ComicProvider()
    private init() {}
    let baseUrl = "https://indonesia-komik.p.rapidapi.com"
    let listComic = "/list-comic"
    let searchComic = "/search-comic"
    let popularComic = "/popular-comic"
    let detailComic = "/detail-comic"
    let readComic = "/read-comic"

    func listComic(completion: @escaping (Result<[Datum], Error>) -> Void) {
        ApiProvider.shared.get(url: baseUrl + listComic) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ListComic.self, from: data)
                    completion(.success(response.data))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchComic(_ term: String, completion: @escaping (Result<[Comic], Error>) -> Void) {
        let parameters: [String: Any] = ["keyword" : term ]
        ApiProvider.shared.post(url: baseUrl + searchComic, parameters: parameters) { (result) in
            switch result {
            case .success(let data):
               let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(SearchComic.self, from: data)
                    completion(.success(response.data.comics))
                } catch {
                    print(parameters)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func popularComic(completion: @escaping (Result<[Comic], Error>) -> Void)  {
        ApiProvider.shared.get(url: baseUrl + popularComic) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(SearchComic.self, from: data)
                    completion(.success(response.data.comics))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func detailChapterList(_ urlComic: String, completion: @escaping (Result<[ChapterList], Error>) -> Void) {
        let parameters: [String: Any] = ["comic_url" : urlComic]
        ApiProvider.shared.post(url: baseUrl + detailComic, parameters: parameters) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do{
                    let response = try decoder.decode(DetailComic.self, from: data)
                    completion(.success(response.data.chapterList))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        
        }
    }
    
    func detailDescribe(_ urlComic: String, completion: @escaping (Result<DetailClass, Error>) -> Void) {
        let parameters: [String: Any] = ["comic_url" : urlComic]
        ApiProvider.shared.post(url: baseUrl + detailComic, parameters: parameters) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do{
                    let response = try decoder.decode(DetailComic.self, from: data)
                    completion(.success(response.data))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        
        }
    }
    
    func readComic(_ urlComic: String, completion: @escaping (Result<[ImageURL], Error>) -> Void) {
        let parameters: [String: Any] = ["comic_url" : urlComic]
        ApiProvider.shared.post(url: baseUrl + readComic, parameters: parameters) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ReadComic.self, from: data)
                    completion(.success(response.data.imageUrls))
                } catch{
                    completion(.failure(error))
            }
            case .failure(let error):
                completion(.failure(error))
        }
    }
    }
}
