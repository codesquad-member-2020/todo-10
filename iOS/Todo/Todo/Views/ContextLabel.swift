//
//  ContextLabel.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

class ContextLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureText()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
        configureText()
    }
    
    private func configureText() {
        lineBreakMode = .byWordWrapping
        numberOfLines = 3
        text = "contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimension"
    }
}
