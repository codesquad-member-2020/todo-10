//
//  Badge.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class Badge: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureAspectRatio()
        configureCornerRadius()
        configureText()
        configureBackgroundColor()
    }

    private func configureAspectRatio() {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
    }
    
    private func configureCornerRadius() {
        layer.cornerRadius = font.pointSize * 0.65
        layer.masksToBounds = true
    }
    
    private func configureText() {
        text = "1"
        textAlignment = .center
    }
    
    private func configureBackgroundColor() {
        backgroundColor = .white
    }
}
