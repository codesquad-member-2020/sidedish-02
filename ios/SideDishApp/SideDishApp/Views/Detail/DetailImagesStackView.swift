//
//  DetailImagesStackView.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/28.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class DetailImagesStackView: UIStackView {

    var imageViews: [UIImageView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureImageViews(count: Int) {
        imageViews = Array<UIImageView>.init(repeating: UIImageView(), count: count)
        imageViews.forEach { _ in
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = .red
            imageView.clipsToBounds = true
            addArrangedSubview(imageView)
        }
    }
    
    func updateDetailImages(at index: Int, image: UIImage?) {
        guard let image = image else { return }
        let imageView = arrangedSubviews[index] as! UIImageView
        let imageRatio = image.size.height / image.size.width
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: frame.width * imageRatio).isActive = true
        imageView.image = image
    }
}
