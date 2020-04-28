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
                let thumbnailViewController = ThumbnailViewController()
                thumbnailViewControllers.append(thumbnailViewController)
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
        configureUI()
    }
    
    func updateThumbnailImage(at index: Int, image: UIImage?) {
        let thumbnailViewController = thumbnailViewControllers[index]
        thumbnailViewController.updateImage(image)
    }
    
    private func configureUI() {
        view.backgroundColor = .clear
    }
    
    func configureImageURLs(_ imageURLs: [String]) {
        self.imageURLs = imageURLs
    }
}

extension ThumbnailsPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = thumbnailViewControllers.firstIndex(where: { $0 == viewController }) ?? 0
        if index == 0 {
            return thumbnailViewControllers[thumbnailViewControllers.count - 1]
        }
        return thumbnailViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = thumbnailViewControllers.firstIndex(where: { $0 == viewController }) ?? 0
        if index == thumbnailViewControllers.count - 1 {
            return thumbnailViewControllers[0]
        }
        return thumbnailViewControllers[index + 1]
    }
}
