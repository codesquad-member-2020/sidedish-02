//
//  ProductList.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/24.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct ProductList: Decodable {
    let products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case products = "banchan"
    }
}
