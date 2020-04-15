//
//  ColumnStackView.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class ColumnStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        axis = .horizontal
        distribution = .fillEqually
        spacing = 8
        translatesAutoresizingMaskIntoConstraints = false
    }
}
