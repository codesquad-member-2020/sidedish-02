//
//  PriceLabelsStackView.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/21.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class PriceLabelsStackView: UIStackView {

    func configurePriceLabels(originalPrice: String?, finalPrice: String) {
        self.removeAll()
        if let originalPrice = originalPrice {
            let originalPriceLabel = OriginalPriceLabel()
            originalPriceLabel.setTitle(text: originalPrice)
            self.addArrangedSubview(originalPriceLabel)
        }
        let finalPriceLabel = FinalPriceLabel()
        finalPriceLabel.setTitle(text: finalPrice)
        self.addArrangedSubview(finalPriceLabel)
    }
}
