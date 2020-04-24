//
//  HomeViewController.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/21.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class SideDishProductsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let navigationTitle = "반찬 코너"
    
    let categories = [
        Category(name: "메인반찬", description: "한그릇 뚝딱 메인 요리", path: "main"),
        Category(name: "국・찌개", description: "김이 모락모락 국・찌개", path: "soup"),
        Category(name: "밑반찬", description: "언제 먹어도 든든한 밑반찬", path: "side")
    ]
    
    lazy var productsList = Array<Products>.init(repeating: Products(), count: categories.count)
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationBar()
        
        categories.enumerated().forEach { (index, category) in
            networkManager.getResource(from: NetworkManager.EndPoints.SideDishes, path: category.path, type: ProductList.self) { (productList, error) in
                if let error = error {
                    print(error)
                }
                
                if let productList = productList {
                    DispatchQueue.main.async {
                        self.productsList[index] = Products(productList.products)
                        self.reloadSection(at: index)
                    }
                }
            }
        }
    }
    
    private func reloadSection(at section: Int) {
        let indexSet = IndexSet(integer: section)
        tableView.beginUpdates()
        tableView.reloadSections(indexSet, with: .bottom)
        tableView.endUpdates()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: ProductHeaderCell.xibName, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: ProductHeaderCell.xibName)
    }
}

extension SideDishProductsViewController: ProductHeaderCellDelegate {
    func didTapProductHeaderCell(at section: Int) {
        // get data using section
    }
}

extension SideDishProductsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: ProductHeaderCell.xibName) as? ProductHeaderCell
        headerCell?.delegate = self
        headerCell?.configureSection(section)
        return headerCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        cell.priceLabelsStackView.configurePriceLabels(originalPrice: "8,000", finalPrice: "6,900원")
        cell.badgeLabelsStackView.configureBadges(["이벤트특가", "론칭특가"])
        return cell
    }
}

extension SideDishProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ProductHeaderCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(identifier: DetailViewController.identifier)
        navigationController?.pushViewController(detailViewController!, animated: true)
    }
}
