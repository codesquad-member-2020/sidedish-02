//
//  BadgeLabel.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/22.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class BadgeLabel: PaddingLabel {

    private let fontSize: CGFloat = 14
    
    private lazy var badgePadding: UIEdgeInsets = .init(top: 2, left: 6, bottom: 2, right: 6)
    
    override var paddingInsets: UIEdgeInsets {
        get { badgePadding }
        set { badgePadding = newValue }
    }
    
    enum BadgeType: String, CaseIterable {
        case event = "이벤트특가"
        case launching = "론칭특가"
        
        var color: UIColor? {
            switch self {
            case .event: return UIColor(named: "badge-event")
            case .launching: return UIColor(named: "badge-gift")
            }
        }
    }

    func setTitle(text: String) {
        self.contentMode = .center
        self.textAlignment = .center
        self.text = text
        self.textColor = .white
        self.font = .systemFont(ofSize: fontSize, weight: .regular)
        self.backgroundColor = BadgeType(rawValue: text)?.color
    }
}
