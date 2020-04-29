//
//  ImageIndexStackView.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/29.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ImageIndexStackView: UIStackView {
    
    static let indexWidth: CGFloat = 6
    private var indexViews = [UIView]()
    
    private var index: Int = 0 {
        didSet {
            indexViews.forEach { $0.alpha = 0.4 }
            indexViews[index].alpha = 1
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        configureNotification()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureStackView()
        configureNotification()
    }
    
    func configureSubViews(count: Int) {
        self.removeAll()
        for _ in 0..<count {
            let indexView = UIView()
            indexView.backgroundColor = .white
            indexView.translatesAutoresizingMaskIntoConstraints = false
            indexView.layer.cornerRadius = Self.indexWidth / 2
            indexView.widthAnchor.constraint(equalToConstant: Self.indexWidth).isActive = true
            indexView.heightAnchor.constraint(equalToConstant: Self.indexWidth).isActive = true
            indexViews.append(indexView)
            addArrangedSubview(indexView)
        }
        index = 0
    }
    
    private func configureStackView() {
        axis = .horizontal
        spacing = 8
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didIndexChanged),
                                               name: ThumbnailsPageViewController.IndexChangedNotification,
                                               object: nil)
    }
    
    @objc func didIndexChanged(notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else { return }
        self.index = index
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: ThumbnailsPageViewController.IndexChangedNotification, object: nil)
    }
}
