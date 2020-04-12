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
    private let titleFieldDelegate = TitleFieldDelegate()
    private let contentView = ContentView()
    private let contentViewDelegate = ContentViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObserver()
        configureView()
        configureCreateButton()
        configureCancelButton()
        configureTitleField()
        configureContentTextView()
    }
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCreateButton),
                                               name: ContentViewDelegate.Notification.isCorrectDidChange,
                                               object: contentViewDelegate)
    }
    
    @objc private func updateCreateButton() {
        if contentViewDelegate.isCorrect {
            createButton.configureEnable()
        } else {
            createButton.configureDisable()
        }
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
                                         cardData: cardData, with: MockCardCreateSuccessStub()) { card in
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
        titleField.delegate = titleFieldDelegate
        
        view.addSubview(titleField)
        let constant: CGFloat = 27
        titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        titleField.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: constant).isActive = true
        titleField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func configureContentTextView() {
        contentView.delegate = contentViewDelegate
        
        view.addSubview(contentView)
        let constant: CGFloat = 27
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        contentView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: constant).isActive = true
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }
}