//
//  SalePriceLabel.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/21.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class FinalPriceLabel: UILabel {

    private let salePriceColor = UIColor(named: "keyColor")!
    private let currencyUnit = "원"
    private let priceFontSize: CGFloat = 17
    private let unitFontSize: CGFloat = 15
    
    func setTitle(text: String) {
        let price = text.components(separatedBy: currencyUnit).first ?? text
        
        let attributedText = NSMutableAttributedString(string: price.priceFormat,
                                            attributes: [
                                                .foregroundColor: salePriceColor,
                                                .font: UIFont.systemFont(ofSize: priceFontSize, weight: .heavy)
                                            ])
        attributedText.append(NSAttributedString(string: currencyUnit,
                                                 attributes: [
                                                     .foregroundColor: salePriceColor,
                                                     .font: UIFont.systemFont(ofSize: unitFontSize, weight: .medium)
                                                 ]))
        self.attributedText = attributedText
    }
}
