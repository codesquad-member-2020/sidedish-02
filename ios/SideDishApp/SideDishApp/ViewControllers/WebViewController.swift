//
//  WebViewController.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/29.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGitHub()
        configureLayout()
    }
    
    private loadGitHub() {
        guard let url = URL(string:"https://github.com/login/oauth/authorize?client_id=5d89cbaa5b442d53d545") else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func configureLayout() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
