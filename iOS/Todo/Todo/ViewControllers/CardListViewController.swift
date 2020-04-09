//
//  ColumnViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit
final class CardListViewController: UIViewController {
    //MARK:- internal property
    private let titleView = TitleView()
    private var titleViewModel: TitleViewModel!
    private var cardListTable = CardListTable()
    private var cardListTableDataSource: CardListTableDataSource!
    private var cardListTableDelegate = CardListTableDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleView()
        configureTableView()
    }
    
    private func configureTitleView() {
        view.addSubview(titleView)
        
        let safeArea = view.safeAreaLayoutGuide
        titleView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        titleView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    
    private func configureTableView() {
        cardListTable.register(CardCell.self, forCellReuseIdentifier: CardCell.reuseIdentifier)
        cardListTable.delegate = cardListTableDelegate
        configureTableConstraints()
    }
    
    private func configureTableConstraints() {
        view.addSubview(cardListTable)
        
        let safeArea = view.safeAreaLayoutGuide
        cardListTable.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        cardListTable.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
        cardListTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        cardListTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    var cardList: CardList? {
        didSet {
            configureTitleViewModel()
            configureDataSource()
        }
    }
    
    private func configureTitleViewModel() {
        guard let cardList = cardList else { return }
        titleViewModel = TitleViewModel(titleModel: TitleModel(title: cardList.title,
                                                               cardsCount: cardList.cards.count),
                                        changed: { titleModel in
                                            guard let titleModel = titleModel else { return }
                                                self.titleView.badge.text = String(titleModel.cardsCount)
                                                self.titleView.titleLabel.text = titleModel.title
        })
    }
    
    private func configureDataSource() {
        guard let cardList = cardList else { return }
        let cardListID = cardList.id
        let cardViewModels = cardList.cards.map { CardViewModel(card: $0)}
        cardListTableDataSource = CardListTableDataSource(cardListID: cardListID, cardViewModels: cardViewModels)
        cardListTable.dataSource = cardListTableDataSource
    }
}

