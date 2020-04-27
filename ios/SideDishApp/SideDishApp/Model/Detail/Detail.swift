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
    let prices: [String]
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let detailImageURLs: [String]
    
    enum CodingKeys: String, CodingKey {
        case thumbnailImageURLs = "thumb_images"
        case title
        case description = "product_description"
        case prices, point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case detailImageURLs = "detail_section"
    }
}
