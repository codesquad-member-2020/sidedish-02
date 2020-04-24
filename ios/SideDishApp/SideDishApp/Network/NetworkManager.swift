//
//  NetworkManager.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/24.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    enum EndPoints {
        static let SideDishes = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan"
    }
    
    func getResource<T: Decodable>(from: String, path: String? = nil, type: T.Type, completion: @escaping (T?, Error?) -> ()) {
        let pathURL = (path != nil) ? "/\(path!)" : ""
        let requestURL = from + pathURL
        AF.request(requestURL).responseDecodable(of: T.self, queue: .main, decoder: JSONDecoder()) { (response) in
            switch response.result {
            case .success(let decodedData):
                completion(decodedData, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

struct Category: Decodable {
    let name: String
    let description: String
    let path: String
}

struct ProductList: Decodable {
    let products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case products = "body"
    }
}

struct Products {
    let products: [Product]
    
    var count: Int {
        get { products.count }
    }
    
    init(_ products: [Product] = []) {
        self.products = products
    }
}

struct Product: Decodable {
    let detailHash: String
    let imageURL: String
    let title: String
    let originalPrice: String?
    let finalPrice: String
    let badges: [String]?
    
    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case imageURL = "image"
        case title
        case originalPrice = "n_price"
        case finalPrice = "s_price"
        case badges = "badge"
    }
}
