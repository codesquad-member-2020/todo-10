//
//  ViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    private let scrollView = CardListScrollView()
    
    override func viewDidLoad() {
        configureScrollView()
        configureCardListsCase()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    private func configureCardListsCase() {
        CardListsUseCase.makeCardLists(with: MockNetworkSuccessStub()) { cardListsDataSource in
            cardListsDataSource?.iterateCardList(with: { cardList in
                let cardListViewController: CardListViewController = {
                    let controller = CardListViewController()
                    controller.cardList = cardList
                    return controller
                }()
                self.addCardListViewController(cardListViewController: cardListViewController)
            })
            
        }
    }
    
    private func addCardListViewController(cardListViewController: CardListViewController) {
        addChild(cardListViewController)
        scrollView.stackView.addArrangedSubview(cardListViewController.view)
        
        cardListViewController.view.translatesAutoresizingMaskIntoConstraints = false
        cardListViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.32).isActive = true
        cardListViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
    }
}
