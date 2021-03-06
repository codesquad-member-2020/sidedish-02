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
    static let height: CGFloat = 68
    
    private let categoryNameFontSize: CGFloat = 13
    private let categoryDescriptionFontSize: CGFloat = 17
    private let borderWidth: CGFloat = 1
    private let categoryNameColor: UIColor? = UIColor(named: "subtitle-gray")
    private let headerViewBackgroundColor: UIColor? = UIColor(named: "headerview-bg")
    private let descriptionTextColor: UIColor? = UIColor(named: "black")
    private let shadowColor: UIColor? = UIColor(named: "header-shadow")
    private let nameToDescriptionConstant: CGFloat = 10
    private let descriptionToBottomConstant: CGFloat = 6
    
    lazy var categoryNameLabel: CategoryLabel = {
        let label = CategoryLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = borderWidth
        label.layer.borderColor = categoryNameColor?.cgColor
        label.textColor = categoryNameColor
        label.font = .systemFont(ofSize: categoryNameFontSize)
        return label
    }()
    
    lazy var categoryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: categoryDescriptionFontSize, weight: .bold)
        label.textColor = descriptionTextColor
        return label
    }()
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
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
        categoryDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -nameToDescriptionConstant).isActive = true
        categoryNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        categoryNameLabel.bottomAnchor.constraint(equalTo: categoryDescriptionLabel.topAnchor, constant: -descriptionToBottomConstant).isActive = true
    }
    
    private func configureUI() {
        contentView.backgroundColor = headerViewBackgroundColor
        configureShadow()
    }
    
    private func configureShadow() {
        layer.shadowOpacity = 0.2
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 2
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
