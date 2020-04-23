//
//  OrderButton.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/23.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

@IBDesignable
class OrderButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = cornerRadius
    }
}
