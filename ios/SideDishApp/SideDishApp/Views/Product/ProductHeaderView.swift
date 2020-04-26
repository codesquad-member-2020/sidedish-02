//
//  ProductHeaderView.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/26.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

protocol ProductHeaderViewDelegate {
    func didTapProductHeaderView(at section: Int)
}

class ProductHeaderView: UITableViewHeaderFooterView {

    static let reuseIdentifier: String = String(describing: self)
    static let height: CGFloat = 80
    
    lazy var categoryNameLabel: CategoryLabel = {
        let label = CategoryLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = borderWidth
        label.layer.borderColor = categoryNameColor?.cgColor
        label.textColor = categoryNameColor
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private var categoryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 19, weight: .bold)
        return label
    }()
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    private let borderWidth: CGFloat = 1
    private let categoryNameColor: UIColor? = UIColor(named: "subtitle-gray")
    
    private var section: Int!
    var delegate: ProductHeaderViewDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureUI()
        configureLayout()
        configureTapRecognizer()
    }
    
    private func configureLayout() {
        contentView.addSubview(categoryNameLabel)
        contentView.addSubview(categoryDescriptionLabel)
        
        categoryDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        categoryDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        categoryNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        categoryNameLabel.bottomAnchor.constraint(equalTo: categoryDescriptionLabel.topAnchor, constant: -8).isActive = true
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
    }
    
    private func configureTapRecognizer() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapHeader))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTapHeader() {
        delegate?.didTapProductHeaderView(at: section)
    }
    
    deinit {
        self.removeGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureHeaderWith(categoryName: String, categoryDescription: String) {
        self.categoryNameLabel.text = categoryName
        self.categoryDescriptionLabel.text = categoryDescription
    }
    
    func configureSection(_ section: Int) {
        self.section = section
    }
}
