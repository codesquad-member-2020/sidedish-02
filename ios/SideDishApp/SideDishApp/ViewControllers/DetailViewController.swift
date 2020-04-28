//
//  DetailViewController.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/23.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    static let identifier = "DetailViewController"
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabelsStackView: PriceLabelsStackView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var detailImagesStackView: DetailImagesStackView!
    
    @IBOutlet weak var gradientLayerContainerView: UIView!
    
    let thumbnailPageViewController = ThumbnailsPageViewController()
    
    private let backButtonColor: UIColor? = UIColor(named: "darkGray-white")
    private let defaultBackgroundColor: UIColor? = UIColor(named: "default-bg")
    private let clearColor: UIColor? = UIColor(named: "detail-clear")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureThumbnailPageViewController()
        configureNavigationBar()
        configureGradientBackgroundView()
        configureScrollView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let thumbnailPageView = thumbnailPageViewController.view!
        thumbnailPageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
    }
    
    private func configureScrollView() {
        scrollView.delegate = self
    }
    
    private func configureThumbnailPageViewController() {
        let thumbnailPageView = thumbnailPageViewController.view!
        scrollView.addSubview(thumbnailPageView)
    }
    
    func configureDetailViewController(title: String, with detail: Detail) {
        thumbnailPageViewController.configureImageURLs(detail.thumbnailImageURLs)
        titleLabel.text = title
        descriptionLabel.text = detail.description
        pointLabel.text = detail.point
        deliveryFeeLabel.text = detail.deliveryFee
        deliveryInfoLabel.text = detail.deliveryInfo
        priceLabelsStackView.configurePriceLabels(originalPrice: detail.originalPrice, finalPrice: detail.finalPrice)
        detailImagesStackView.configureImageViews(count: detail.detailImageURLs.count)
    }
    
    func updateThumbnailImage(at index: Int, image: UIImage?) {
        thumbnailPageViewController.updateThumbnailImage(at: index, image: image)
    }
    
    func updateDetailImagesStackView(at index: Int, image: UIImage?) {
        detailImagesStackView.updateDetailImages(at: index, image: image)
    }
    
    private func configureGradientBackgroundView() {
        let gradientLayer = CAGradientLayer()
        gradientLayerContainerView.backgroundColor = .clear
        gradientLayer.colors = [clearColor!.cgColor, defaultBackgroundColor!.cgColor, defaultBackgroundColor!.cgColor]
        gradientLayer.locations = [0, 0.4, 1]
        gradientLayer.frame = gradientLayerContainerView.bounds
        gradientLayerContainerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK:- NavigationBar Configuration
    
    private func configureNavigationBar() {
        let backButtonImage = UIImage(named: "back.button")
        let backButtonItem = UIBarButtonItem.init(image: backButtonImage, style: .plain, target: self, action: #selector(handleBack))
        backButtonItem.tintColor = backButtonColor
        self.navigationItem.setLeftBarButton(backButtonItem, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    @objc private func handleBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        guard offsetY < 0 else { return }
        let pageView = thumbnailPageViewController.view!
        let width = self.view.frame.width + (-offsetY)
        pageView.frame = .init(x: offsetY / 2, y: offsetY, width: width, height: width)
    }
}
