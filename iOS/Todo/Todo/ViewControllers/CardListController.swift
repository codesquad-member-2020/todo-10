//
//  ColumnViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit
final class CardListController: UIViewController {
    private let titleView = TitleView()
    private let cardListTable = CardListTable()
    private let cardListTableDataSource = CardListTableDataSource()
    private let cardListTableDelegate = CardListTableDelegate()
    
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
        cardListTable.dataSource = cardListTableDataSource
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
}

