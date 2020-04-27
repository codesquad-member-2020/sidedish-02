//
//  ThumbnailsPageViewController.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/28.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ThumbnailsPageViewController: UIPageViewController {

    private var thumbnailViewControllers = [UIViewController]()
    
    private var imageURLs: [String]! {
        didSet {
            imageURLs.forEach { (_) in
                let vc = UIViewController()
                vc.view.backgroundColor = UIColor(displayP3Red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat.random(in: 0.0...1.0), alpha: 1)
                thumbnailViewControllers.append(vc)
            }
            setViewControllers([thumbnailViewControllers.first!], direction: .forward, animated: false)
        }
    }
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        view.backgroundColor = .green
    }
    
    func configureImageURLs(_ imageURLs: [String]) {
        self.imageURLs = imageURLs
    }
}

extension ThumbnailsPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = thumbnailViewControllers.firstIndex(where: { $0 == viewController }) ?? 0
        if index == 0 { return nil }
        return thumbnailViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = thumbnailViewControllers.firstIndex(where: { $0 == viewController }) ?? 0
        if index == thumbnailViewControllers.count - 1 { return nil }
        return thumbnailViewControllers[index + 1]
    }
}
