//
//  ProductHeaderView.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/21.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ProductHeaderCell: UITableViewCell {

    static let xibName = "ProductHeaderCell"
    static let height: CGFloat = 80
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: CategoryLabel!
    
    private let borderWidth: CGFloat = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configureHeaderWith(category: String, title: String) {
        self.categoryLabel.text = category
        self.titleLabel.text = title
    }

    private func configure() {
        categoryLabel.layer.borderWidth = borderWidth
        categoryLabel.layer.borderColor = UIColor(named: "subtitle-gray")?.cgColor
    }
}
