//
//  CardListScrollView.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class ColumnScrollView: UIScrollView {
    let columnStackView = ColumnStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        configureStackView()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false 
    }
    
    private func configureStackView() {
        addSubview(columnStackView)
        
        columnStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        columnStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        columnStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentLayoutGuide.widthAnchor.constraint(equalTo: columnStackView.widthAnchor, multiplier: 1).isActive = true
    }
}
