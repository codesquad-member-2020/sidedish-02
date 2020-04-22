//
//  BadgeLabel.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/22.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
    
    var paddingInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: paddingInsets.top, left: paddingInsets.left, bottom: paddingInsets.bottom, right: paddingInsets.right)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + paddingInsets.left + paddingInsets.right,
                      height: size.height + paddingInsets.top + paddingInsets.bottom)
    }
}

