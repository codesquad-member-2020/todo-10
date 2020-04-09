//
//  CardListScrollView.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class CardListScrollView: UIScrollView {
    let stackView = CardListStackView()
    
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
        addSubview(stackView)
        
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentLayoutGuide.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1).isActive = true
    }
}

final class CardListStackView: UIStackView {
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
