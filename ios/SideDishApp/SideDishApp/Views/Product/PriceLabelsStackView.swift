//
//  PriceLabelsStackView.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/21.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class PriceLabelsStackView: UIStackView {

    func configurePriceLabels(normalPrice: String?, salePrice: String) {
        self.removeAll()
        if let normalPrice = normalPrice {
            let normalPriceLabel = NormalPriceLabel()
            normalPriceLabel.setTitle(text: normalPrice)
            self.addArrangedSubview(normalPriceLabel)
        }
        let salePriceLabel = SalePriceLabel()
        salePriceLabel.setTitle(text: salePrice)
        self.addArrangedSubview(salePriceLabel)
    }
}
