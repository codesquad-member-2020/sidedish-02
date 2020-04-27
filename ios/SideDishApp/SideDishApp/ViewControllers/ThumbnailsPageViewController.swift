//
//  ThumbnailsPageViewController.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/28.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ThumbnailsPageViewController: UIPageViewController {

    private var thumbnailViewControllers = [ThumbnailViewController]()
    
    private var imageURLs: [String]! {
        didSet {
            imageURLs.forEach { (_) in
                let vc = ThumbnailViewController()
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
