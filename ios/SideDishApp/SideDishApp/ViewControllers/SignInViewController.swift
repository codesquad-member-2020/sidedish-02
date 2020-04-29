//
//  SignInViewController.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/29.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var signInGitHubButton: UIButton!
    
    static let identifier: String = "SignInViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureButton()
    }
    
    private func configureButton() {
        signInGitHubButton.layer.cornerRadius = 8
    }
    
    @IBAction func signInGitHubButtonTapped(_ sender: Any) {
        let webViewController = WebViewController()
        present(webViewController, animated: true)
    }
}

