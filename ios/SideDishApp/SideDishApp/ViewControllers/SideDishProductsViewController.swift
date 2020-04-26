//
//  HomeViewController.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/21.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit
import Toaster

class SideDishProductsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let navigationTitle = "반찬 코너"
    private let defaultBackgroundColor: UIColor? = UIColor(named: "default-bg")
    
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

        fetchCategories()
    }
    
    private func fetchCategories() {
        categories.enumerated().forEach { (section, category) in
            fetchProducts(at: section, of: category)
        }
    }
    
    private func fetchProducts(at section: Int, of category: Category) {
        networkManager.getResource(from: NetworkManager.EndPoints.SideDishes, path: category.path, type: ProductList.self) { (productList, error) in
            if error != nil {
                Toast(text: "네트워크 에러로 데이터를 불러올 수 없습니다.", delay: 0, duration: 3).show()
                return
            }
            guard let productList = productList else { return }
            DispatchQueue.main.async {
                self.productsList[section] = Products(productList.products)
                self.reloadSection(at: section)
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
        navigationController?.navigationBar.barTintColor = defaultBackgroundColor
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ProductHeaderView.self, forHeaderFooterViewReuseIdentifier: ProductHeaderView.reuseIdentifier)
    }
}

extension SideDishProductsViewController: ProductHeaderViewDelegate {
    func didTapProductHeaderView(at section: Int) {
        let category = categories[section]
        let products = productsList[section]
        
        Toast(text: "\(category.name), 총 \(products.count)개 상품이 있습니다.", delay: 0, duration: 2).show()
    }
}

extension SideDishProductsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProductHeaderView.reuseIdentifier) as! ProductHeaderView
        let category = categories[section]
        headerView.delegate = self
        headerView.configureSection(section)
        headerView.configureHeaderWith(categoryName: category.name, categoryDescription: category.description)
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        let product = productsList[indexPath.section][indexPath.row]
        
        networkManager.fetchImage(from: product.imageURL) { (result) in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.configureProductImage(image)
                }
            case .failure(_):
                break
            }
        }
        cell.configureProductCell(with: product)
        return cell
    }
}

extension SideDishProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ProductHeaderView.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(identifier: DetailViewController.identifier)
        navigationController?.pushViewController(detailViewController!, animated: true)
    }
}
