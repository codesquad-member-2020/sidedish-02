//
//  ThumbnailViewController.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/28.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ThumbnailViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(named: "loading-color")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureImageView()
    }
    
    func updateImage(_ image: UIImage?) {
        self.imageView.image = image
    }
    
    private func configureImageView() {
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
