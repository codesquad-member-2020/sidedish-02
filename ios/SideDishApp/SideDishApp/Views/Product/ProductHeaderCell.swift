//
//  ProductHeaderView.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/21.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

protocol ProductHeaderCellDelegate {
    func didTapProductHeaderCell(at section: Int)
}

class ProductHeaderCell: UITableViewCell {

    static let xibName = "ProductHeaderCell"
    static let height: CGFloat = 80
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: CategoryLabel!
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    private let borderWidth: CGFloat = 1
    
    private var section: Int!
    var delegate: ProductHeaderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        configureTapRecognizer()
    }
    
    private func configureTapRecognizer() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapHeader))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTapHeader() {
        delegate?.didTapProductHeaderCell(at: section)
    }
    
    deinit {
        self.removeGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureHeaderWith(category: String, title: String) {
        self.categoryLabel.text = category
        self.titleLabel.text = title
    }
    
    func configureSection(_ section: Int) {
        self.section = section
    }

    private func configure() {
        categoryLabel.layer.borderWidth = borderWidth
        categoryLabel.layer.borderColor = UIColor(named: "subtitle-gray")?.cgColor
    }
}
