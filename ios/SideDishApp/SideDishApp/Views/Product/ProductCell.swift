//
//  ProductCell.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/21.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    static let identifier = "product"
    static let height: CGFloat = 130

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabelsStackView: PriceLabelsStackView!
    @IBOutlet weak var badgeLabelsStackView: BadgeLabelsStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureImageView()
    }
    
    private func configureImageView() {
        productImageView.backgroundColor = UIColor(named: "keyColor")
        productImageView.layer.cornerRadius = productImageView.frame.height / 2
    }
}
