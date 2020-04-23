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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationBar()
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

extension SideDishProductsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: ProductHeaderCell.xibName) as? ProductHeaderCell
        return headerCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        return cell
    }
}

extension SideDishProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ProductHeaderCell.height
    }
}
