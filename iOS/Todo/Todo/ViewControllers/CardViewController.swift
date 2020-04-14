//
//  PlusCardViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/10.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

protocol CardViewControllerDelegate {
    func cardViewControllerDidCardCreate(_ cardViewModel: CardViewModel)
    func cardViewControllerDidCardEdit(_ willCardViewModel: WillEditCardViewModel)
}

class CardViewController: UIViewController {
    var columnID: Int?
    var delegate: CardViewControllerDelegate?
    private let cancelButton = CancelButton()
    private let titleFieldDelegate = TitleFieldDelegate()
    private let contentViewDelegate = ContentViewDelegate()
    fileprivate let createButton = CreateButton()
    fileprivate let titleField = TitleField()
    fileprivate let contentView = ContentView()
    
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
        view.addSubview(createButton)
        let constant: CGFloat = 27
        createButton.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
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

@objc protocol CardCreatable where Self: CardViewController {
    func createCard()
}

final class NewCardViewController: CardViewController, CardCreatable {
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.addTarget(self, action: #selector(createCard), for: .touchUpInside)
    }
    
    @objc func createCard() {
        guard let columnID = columnID else { return }
        guard let content = contentView.text else { return }
        guard let cardData = try? JSONEncoder().encode(NewCard(title: titleField.text, content: content)) else { return }
        NewCardViewModelUseCase.makeNewCardViewModel(columnID: columnID,
                                                     cardData: cardData, with: NetworkManager()) { cardViewModel in
                                                        guard let cardViewModel = cardViewModel else { return }
                                                        self.delegate?.cardViewControllerDidCardCreate(cardViewModel)
        }
        dismiss(animated: true, completion: nil)
    }
}

final class EditingCardViewController: CardViewController, CardCreatable {
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.addTarget(self, action: #selector(createCard), for: .touchUpInside)
    }
    
    @objc func createCard() {
        guard let columnID = columnID else { return }
        guard let content = contentView.text else { return }
        guard let cardData = try? JSONEncoder().encode(NewCard(title: titleField.text, content: content)) else { return }
        guard let cardID = willEditCardViewModel?.cardViewModel.cardID else { return }
        EditedCardViewModelUseCase.makeEditedCardViewModel(columnID: columnID, cardID: cardID,
                                                           cardData: cardData, with: NetworkManager()) { cardViewModel in
                                                            guard let cardViewModel = cardViewModel else { return }
                                                            self.willEditCardViewModel?.cardViewModel = cardViewModel
                                                            guard let willEditCardViewModel = self.willEditCardViewModel else { return }
                                                            self.delegate?.cardViewControllerDidCardEdit(willEditCardViewModel)
        }
        dismiss(animated: true, completion: nil)
    }
    
    var willEditCardViewModel: WillEditCardViewModel? {
        didSet {
            willEditCardViewModel?.cardViewModel.performBind(changed: { card in
                DispatchQueue.main.async {
                    self.titleField.text = card?.title
                    self.contentView.text = card?.content
                }
            })
        }
    }
}

struct WillEditCardViewModel {
    let row: Int
    var cardViewModel: CardViewModel
}
