//
//  Detail.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/27.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct Detail: Decodable {
    
    let thumbnailImageURLs: [String]
    let title: String?
    let description: String
    let originalPrice: String
    let finalPrice: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let detailImageURLs: [String]
    
    enum CodingKeys: String, CodingKey {
        case thumbnailImageURLs = "thumbImages"
        case title, description
        case originalPrice, finalPrice, point, deliveryInfo, deliveryFee
        case detailImageURLs = "detailImages"
    }
}
