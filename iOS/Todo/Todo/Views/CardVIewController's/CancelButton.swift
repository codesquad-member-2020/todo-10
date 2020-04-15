//
//  CancelButton.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//
import UIKit

final class CancelButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        let cancelImage = UIImage(systemName: "x.circle.fill")
        setImage(cancelImage, for: .normal)
        imageView?.contentMode = .scaleAspectFill
        imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        tintColor = .systemRed
        translatesAutoresizingMaskIntoConstraints = false
    }
}
