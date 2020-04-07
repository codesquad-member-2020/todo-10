//
//  TitleView.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class TitleView: UIView {
    let badge = Badge()
    let plusButton = PlusButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        backgroundColor = .lightGray
        
        configureBadge()
        configurePlusButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureBadge()
        configurePlusButton()
    }
    
    private func configureBadge() {
        addSubview(badge)
        let constant: CGFloat = 13
        badge.topAnchor.constraint(equalTo: self.topAnchor,
                                   constant: constant).isActive = true
        badge.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                       constant: constant).isActive = true
        badge.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                      constant: -constant).isActive = true
    }
    
    private func configurePlusButton() {
        addSubview(plusButton)
        let constant: CGFloat = 13
        plusButton.topAnchor.constraint(equalTo: self.topAnchor,
                                        constant: constant).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                             constant: -constant).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                           constant: -constant).isActive = true
    }
    
}
