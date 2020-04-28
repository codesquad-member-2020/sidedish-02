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
    
    var categories = [Category]()
    
    lazy var productsList = Array<Products>.init(repeating: Products(), count: categories.count)
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationBar()

        fetchCategories()
    }
    
    private func fetchCategories() {
        networkManager.getResource(from: NetworkManager.EndPoints.Categories, type: [Category].self) { (categories, error) in
            if error != nil {
                DispatchQueue.main.async {
                    Toast(text: "네트워크 에러로 데이터를 불러올 수 없습니다.", delay: 0, duration: 3).show()
                }
                return
            }
            guard let categories = categories else { return }
            self.categories = categories
            self.tableView.reloadData()
            self.categories.enumerated().forEach { (section, category) in
                self.fetchProducts(at: section, of: category)
            }
        }
    }
    
    private func fetchProducts(at section: Int, of category: Category) {
        networkManager.getResource(from: NetworkManager.EndPoints.SideDishes, path: category.path, type: ProductList.self) { (productList, error) in
            if error != nil {
                DispatchQueue.main.async {
                    Toast(text: "네트워크 에러로 데이터를 불러올 수 없습니다.", delay: 0, duration: 3).show()
                }
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
        
        let url = URL(string: product.imageURL)!
        let cachedImageFileURL = try! FileManager.default
            .url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(url.lastPathComponent)
        
        if let cachedData = try? Data(contentsOf: cachedImageFileURL) {
            let image = UIImage(data: cachedData)
            cell.configureProductImage(image)
        } else {
            networkManager.fetchImage(from: product.imageURL, cachedImageFileURL: cachedImageFileURL) { (result) in
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
        let detailViewController = storyboard?.instantiateViewController(identifier: DetailViewController.identifier) as! DetailViewController
        let product = productsList[indexPath.section][indexPath.row]
        let detailHash = product.detailHash
        networkManager.getResource(from: NetworkManager.EndPoints.Detail, path: detailHash, type: Detail.self) { (detail, error) in
            guard let detail = detail else { return }
            DispatchQueue.main.async {
                detailViewController.configureDetailViewController(title: product.title, with: detail)
            }
            
            // 썸네일 이미지 네트워크 요청 및 업데이트
            detail.thumbnailImageURLs.enumerated().forEach { (index, url) in
                self.networkManager.fetchImage(from: url) { (result) in
                    switch result {
                    case .success(let data):
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            detailViewController.updateThumbnailImage(at: index, image: image)
                        }
                    case .failure(_):
                        break
                    }
                }
            }
            
            // 상세 이미지 네트워크 요청 및 업데이트
            detail.detailImageURLs.enumerated().forEach { (index, url) in
                self.networkManager.fetchImage(from: url) { (result) in
                    switch result {
                    case .success(let data):
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            detailViewController.updateDetailImagesStackView(at: index, image: image)
                        }
                    case .failure(_):
                        break
                    }
                }
            }
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
