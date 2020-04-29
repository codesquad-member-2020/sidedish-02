//
//  BadgesStackView.swift
//  SideDishApp
//
//  Created by Cory Kim on 2020/04/22.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class BadgeLabelsStackView: UIStackView {
    
    func configureBadges(_ badges: [String]?) {
        self.removeAll()
        guard let badges = badges else {
            let badgeLabel = BadgeLabel()
            badgeLabel.setEmpty()
            self.addArrangedSubview(badgeLabel)
            return
        }
        badges.forEach { (badge) in
            let badgeLabel = BadgeLabel()
            badgeLabel.setTitle(text: badge)
            self.addArrangedSubview(badgeLabel)
        }
    }
}
