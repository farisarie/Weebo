//
//  ApiProvider.swift
//  KumparanTest
//
//  Created by yoga arie on 15/09/22.
//

import Foundation
import Alamofire

class ApiProvider {
    static var shared: ApiProvider = ApiProvider()
    private init() {}
    
    let headers: HTTPHeaders = ["X-RapidAPI-Key"  : "435ef106aemsh79e12eacf241ceap108d0fjsn0e32a4beb036",
                                "X-RapidAPI-Host" : "indonesia-komik.p.rapidapi.com"]
    
    
    func get(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(
            url,
            method: .get,
            encoding: URLEncoding.default,
            headers: headers)
        .responseData { (response) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
  
    func post(url: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers)
        .responseData { (response) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
