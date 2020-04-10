//
//  PlusCardViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/10.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class PlusCardViewController: UIViewController {
    private let cancelButton = CancelButton()
    private let createButton = CreateButton()
    private let titleField = TitleField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCreateButton()
        configureCancelButton()
        configureTitleField()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureCreateButton() {
        view.addSubview(createButton)
        let constant: CGFloat = 27
        createButton.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
    }
    
    private func configureCancelButton() {
        view.addSubview(cancelButton)
        let constant: CGFloat = 27
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: createButton.leadingAnchor, constant: -constant).isActive = true
    }
    
    private func configureTitleField() {
        view.addSubview(titleField)
        let constant: CGFloat = 27
        titleField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: constant).isActive = true
        titleField.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: constant).isActive = true
    }
}

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
        let createImage = UIImage(systemName: "arrow.up.circle.fill")
        setImage(createImage, for: .normal)
        imageView?.contentMode = .scaleAspectFill
        imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        tintColor = .systemBlue
        translatesAutoresizingMaskIntoConstraints = false
    }
}

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
 
    private static let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    
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
