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
        plusButton.tintColor = .black
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
        badge.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        badge.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        badge.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func configurePlusButton() {
        addSubview(plusButton)
        plusButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
