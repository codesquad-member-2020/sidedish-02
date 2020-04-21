//
//  NormalPriceLabel.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/21.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class NormalPriceLabel: UILabel {

    private let normalPriceColor = UIColor(named: "subtitle-gray")
    private let fontSize: CGFloat = 14
    
    func setTitle(text: String) {
        attributedText = NSAttributedString(string: text.priceFormat,
                                            attributes: [
                                                .foregroundColor: normalPriceColor,
                                                .font: UIFont.systemFont(ofSize: fontSize),
                                                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                                .strikethroughColor: normalPriceColor,
                                            ])
    }
}
