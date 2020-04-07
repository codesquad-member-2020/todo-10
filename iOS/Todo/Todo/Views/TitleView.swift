//
//  TitleView.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class TitleView: UIView {
    let badge: UILabel = {
        let badge = UILabel()
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.widthAnchor.constraint(equalTo: badge.heightAnchor, multiplier: 1).isActive = true
        badge.layer.cornerRadius = badge.font.pointSize * 0.60
        badge.layer.masksToBounds = true
        badge.text = "1"
        badge.textAlignment = .center
        badge.backgroundColor = .white
        return badge
    }()
    
    let plusButton: UIButton = {
        let plusButton = UIButton()
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        return plusButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        let constant: CGFloat = 8
        badge.topAnchor.constraint(equalTo: self.topAnchor,
                                   constant: constant).isActive = true
        badge.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                       constant: constant).isActive = true
        badge.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                      constant: constant).isActive = true
    }
    
    private func configurePlusButton() {
        addSubview(plusButton)
        let constant: CGFloat = 8
        plusButton.topAnchor.constraint(equalTo: self.topAnchor,
                                        constant: constant).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                             constant: -constant).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                           constant: constant).isActive = true
    }
    
}
