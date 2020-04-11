//
//  PlusCardViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/10.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

protocol CardCreatable {
    func cardDidCreate(_ card: Card)
}

final class CardViewController: UIViewController {
    var delegate: CardCreatable?
    private let cancelButton = CancelButton()
    private let createButton = CreateButton()
    private let titleField = TitleField()
    private let contentView = ContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCreateButton()
        configureCancelButton()
        configureTitleField()
        configureContentTextView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureCreateButton() {
        createButton.addTarget(self, action: #selector(createCard), for: .touchUpInside)
        
        view.addSubview(createButton)
        let constant: CGFloat = 27
        createButton.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
    }
    
    var columnID: Int?
    @objc private func createCard() {
        guard let columnID = columnID else { return }
        guard let content = contentView.text else { return }
        guard let cardData = try? JSONEncoder().encode(NewCard(title: titleField.text, content: content)) else { return }
        CreateUseCase.makeCreateResponse(columnID: columnID,
                                         cardData: cardData, with: NetworkManager()) { card in
                                            guard let card = card else { return }
                                            self.delegate?.cardDidCreate(card)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func configureCancelButton() {
        cancelButton.addTarget(self, action: #selector(cancelCardViewController), for: .touchUpInside)
        
        view.addSubview(cancelButton)
        let constant: CGFloat = 27
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: createButton.leadingAnchor, constant: -constant).isActive = true
    }
    
    @objc private func cancelCardViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    private func configureTitleField() {
        view.addSubview(titleField)
        let constant: CGFloat = 27
        titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        titleField.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: constant).isActive = true
        titleField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func configureContentTextView() {
        view.addSubview(contentView)
        let constant: CGFloat = 27
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        contentView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: constant).isActive = true
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
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

final class ContentView: UITextView {
    static let placeHolderString = "Add a message what to do"
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configureText()
        configureBorder()
        configureInsets()
    }
    
    private func configureText() {
        font = UIFont.boldSystemFont(ofSize: 20)
        text = ContentView.placeHolderString
        textColor = .placeholderText
    }
    
    private func configureBorder() {
        layer.borderWidth = 0.9
        layer.borderColor = UIColor.placeholderText.cgColor
        layer.cornerRadius = 13
    }
    
    private static let padding = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 0)
    private func configureInsets() {
        textContainerInset = ContentView.padding
    }
}
