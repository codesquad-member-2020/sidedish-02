//
//  SalePriceLabel.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/21.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class SalePriceLabel: UILabel {

    private let salePriceColor = UIColor(named: "keyColor")
    private let fontSize: CGFloat = 17
    
    override var text: String? {
        didSet {
            self.textColor = salePriceColor
            self.font = .systemFont(ofSize: fontSize, weight: .heavy)
        }
    }
}
