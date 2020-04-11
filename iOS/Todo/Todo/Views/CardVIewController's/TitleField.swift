//
//  TitleField.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class TitleField: UITextField {
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
        font = UIFont.boldSystemFont(ofSize: 30)
        placeholder = "Title"
    }
    
    private static let padding = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 0)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: TitleField.padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: TitleField.padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: TitleField.padding)
    }
}
