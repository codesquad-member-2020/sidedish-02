//
//  Products.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/24.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct Products {
    let products: [Product]
    
    var count: Int {
        get { products.count }
    }
    
    init(_ products: [Product] = []) {
        self.products = products
    }
    
    subscript(index: Int) -> Product {
        return products[index]
    }
}
