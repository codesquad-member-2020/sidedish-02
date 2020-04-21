//
//  ProductSectionHeaderView.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/21.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ProductSectionHeaderView: UIView {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    private let borderWidth: CGFloat = 1

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        categoryLabel.layer.borderWidth = borderWidth
        categoryLabel.layer.borderColor = UIColor(named: "subtitle-gray")?.cgColor
    }
}
