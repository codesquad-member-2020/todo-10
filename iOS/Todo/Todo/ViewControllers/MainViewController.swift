//
//  ViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    private let cardListViewControllers = [CardListController(), CardListController(), CardListController(), CardListController(), CardListController()]
    private let scrollView = CardListScrollView()
    private let networkManager = NetworkManager()
    override func viewDidLoad() {
        configureScrollView()
        configureCardListsCase()
        configureCardLists()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    private func configureCardListsCase() {
        CardListsCase.makeCardLists(with: NetworkManager()) {
            
        }
    }
    
    private func configureCardLists() {
        cardListViewControllers.forEach {
            addChild($0)
            scrollView.stackView.addArrangedSubview($0.view)
            $0.view.translatesAutoresizingMaskIntoConstraints = false
            $0.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.32).isActive = true
            $0.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        }
    }
}
