//
//  CreateButton.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class CreateButton: UIButton {
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
        configureImage()
        configureDisable()
    }
    
    private func configureImage() {
        let createImage = UIImage(systemName: "arrow.up.circle.fill")
        setImage(createImage, for: .normal)
        imageView?.contentMode = .scaleAspectFill
        imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    }
    
    func configureDisable() {
        tintColor = .darkGray
        isEnabled = false
    }
    
    func configureEnable() {
        tintColor = .systemBlue
        isEnabled = true
    }
}
