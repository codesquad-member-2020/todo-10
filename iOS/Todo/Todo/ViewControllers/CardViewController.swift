//
//  PlusCardViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/10.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

protocol CardViewControllerDelegate: class {
    func cardViewControllerDidCardCreate(_ cardViewModel: CardViewModel)
    func cardViewControllerDidCardEdit(_ cardViewModel: CardViewModel, row: Int)
    func cardViewControllerDidMake(logID: LogID)
}

class CardViewController: UIViewController {
    var columnID: Int?
    weak var delegate: CardViewControllerDelegate?
    private let cancelButton = CancelButton()
    private let titleField = TitleField()
    private let titleFieldDelegate = TitleFieldDelegate()
    private let contentViewDelegate = ContentViewDelegate()
    private let createButton = CreateButton()
    private let contentView = ContentView()
    
    deinit {
        createButton.removeTarget(self, action: #selector(createCard), for: .touchUpInside)
        cancelButton.removeTarget(self, action: #selector(dismissCardViewController), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
        configureView()
        configureCreateButton()
        configureCancelButton()
        configureTitleField()
        configureContentTextView()
    }
    
    private func configureObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCreateButton),
                                               name: Notification.isCorrectDidChange,
                                               object: contentViewDelegate)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCreateButton),
                                               name: Notification.isCorrectDidChange,
                                               object: titleFieldDelegate)
    }
    
    @objc private func updateCreateButton() {
        if contentViewDelegate.isCorrect, titleFieldDelegate.isCorrect {
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
    
    @objc func createCard() {
        
    }
    
    private func configureCancelButton() {
        cancelButton.addTarget(self, action: #selector(dismissCardViewController), for: .touchUpInside)
        
        view.addSubview(cancelButton)
        let constant: CGFloat = 27
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: createButton.leadingAnchor, constant: -constant).isActive = true
    }
    
    @objc private func dismissCardViewController() {
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
    
    func configurePlaceHolderVersion() {
        contentView.configurePlaceHolderVersion()
    }
    
    func configureTextColorWritingVersion() {
        contentView.configureTextWriting()
    }
    
    func configureTitle(text: String?) {
        titleField.text = text
        titleFieldDelegate.validText(titleField)
    }
    
    func configureContent(text: String) {
        contentView.text = text
        contentViewDelegate.validText(contentView)
    }
    
    func generateNewCard() -> NewCard {
        return NewCard(title: titleField.text, content: contentView.text)
    }
}

extension CardViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
