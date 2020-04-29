//
//  NormalPriceLabel.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/21.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class OriginalPriceLabel: UILabel {

    private let labelColor = UIColor(named: "subtitle-gray")!
    private let fontSize: CGFloat = 14
    
    func setTitle(text: String) {
        attributedText = NSAttributedString(string: text.priceFormat,
                                            attributes: [
                                                .foregroundColor: labelColor,
                                                .font: UIFont.systemFont(ofSize: fontSize),
                                                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                                .strikethroughColor: labelColor,
                                            ])
        self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}
