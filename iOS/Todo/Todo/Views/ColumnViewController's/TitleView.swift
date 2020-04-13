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
    let titleLabel = TitleLabel()
    let plusButton = PlusButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureTitleView()
        configureBadge()
        configureTitleLabel()
        configurePlusButton()
    }
    
    private func configureTitleView() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        backgroundColor = .lightGray
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
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        let constant: CGFloat = 13
        titleLabel.leadingAnchor.constraint(equalTo: badge.trailingAnchor,
                                            constant: constant).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                        constant: constant).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,
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
        textAlignment = .center
    }
    
    private func configureBackgroundColor() {
        backgroundColor = .white
    }
}

final class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.boldSystemFont(ofSize: 20)
    }
}

protocol PlusButtonDelegate {
    func showNewCardViewController()
}

final class PlusButton: UIButton {
    var delegate: PlusButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureDelegete()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        configureDelegete()
    }
    
    deinit {
        removeTarget(self, action: #selector(plusButtonTouched), for: .touchUpInside)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    private func configureDelegete() {
        addTarget(self, action: #selector(plusButtonTouched), for: .touchUpInside)
    }
    
    @objc private func plusButtonTouched() {
        delegate?.showNewCardViewController()
    }
}
