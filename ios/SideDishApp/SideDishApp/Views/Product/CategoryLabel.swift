//
//  CategoryLabel.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/22.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class CategoryLabel: PaddingLabel {

    lazy var categoryInsets: UIEdgeInsets = .init(top: 2, left: 4, bottom: 2, right: 4)
    
    override var paddingInsets: UIEdgeInsets {
        get { categoryInsets }
        set { categoryInsets = newValue }
    }
}
