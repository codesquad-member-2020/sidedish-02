//
//  Product.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/24.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

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
