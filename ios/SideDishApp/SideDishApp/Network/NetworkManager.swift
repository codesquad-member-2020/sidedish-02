//
//  NetworkManager.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/24.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkErrorCase : Error {
    case InvalidURL
    case NotFound
}

class NetworkManager {
    
    enum EndPoints {
        static let SideDishes = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan"
    }
    
    func getResource<T: Decodable>(from: String, path: String = "", type: T.Type, completion: @escaping (T?, Error?) -> ()) {
        let pathURL = (path != "") ? "/\(path)" : ""
        let requestURL = from + pathURL
        AF.request(requestURL).responseDecodable(of: T.self, queue: .global(qos: .background), decoder: JSONDecoder()) { (response) in
            switch response.result {
            case .success(let decodedData):
                completion(decodedData, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func fetchImage(from: String, completion: @escaping (Result<Data, NetworkErrorCase>) -> Void) {
        let fileName = String(from.split(separator: "/").last!)
        let cachedImageFileURL = try! FileManager.default
            .url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(fileName)
        let URLRequest = URL(string: from)!
        
        if let cachedData = try? Data(contentsOf: cachedImageFileURL) {
            completion(.success(cachedData))
            return
        } else {
            URLSession.shared.downloadTask(with: URLRequest) { (url, _, error) in
                if error != nil { completion(.failure(.InvalidURL)) }
                guard let url = url else { completion(.failure(.InvalidURL)); return }
                guard let data = try? Data(contentsOf: url) else { completion(.failure(.InvalidURL)); return }
                // temp url의 data를 cachedImageFileURL에 저장
                try? FileManager.default.copyItem(at: url, to: cachedImageFileURL)
                try? FileManager.default.removeItem(at: url)
                completion(.success(data))
            }.resume()
        }
    }
}
