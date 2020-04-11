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
    private var columnTable = CardListTable()
    private var columnTableDataSource: ColumnTableDataSource!
    private var columnTableDelegate = CardListTableDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleView()
        configureTableView()
        configureObserver()
    }
    
    private func configureTitleView() {
        configurePlusButtonDelegate()
        view.addSubview(titleView)
        
        let safeArea = view.safeAreaLayoutGuide
        titleView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        titleView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    private func configurePlusButtonDelegate() {
        titleView.plusButton.delegate = self
    }
    
    private func configureTableView() {
        columnTable.register(CardCell.self, forCellReuseIdentifier: CardCell.reuseIdentifier)
        columnTable.delegate = columnTableDelegate
        configureTableConstraints()
    }
    
    private func configureTableConstraints() {
        view.addSubview(columnTable)
        
        let safeArea = view.safeAreaLayoutGuide
        columnTable.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        columnTable.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
        columnTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        columnTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateBadge),
                                               name: ColumnTableDataSource.Notification.cardViewModelsDidChange,
                                               object: columnTableDataSource)
    }
    
    @objc private func updateBadge() {
        DispatchQueue.main.async {
            self.titleView.badge.text = String(self.columnTableDataSource.cardViewModelsCount)
        }
    }
    
    var column: Column? {
        didSet {
            configureTitleViewModel()
            configureDataSource()
        }
    }
    
    private func configureTitleViewModel() {
        guard let column = column else { return }
        titleViewModel = TitleViewModel(titleModel: TitleModel(title: column.title,
                                                               cardsCount: column.cards.count),
                                        changed: { titleModel in
                                            guard let titleModel = titleModel else { return }
                                            self.titleView.badge.text = String(titleModel.cardsCount)
                                            self.titleView.titleLabel.text = titleModel.title
        })
    }
    
    private func configureDataSource() {
        guard let column = column else { return }
        let columnID = column.id
        let cardViewModels = column.cards.map { CardViewModel(card: $0)}
        columnTableDataSource = ColumnTableDataSource(columnID: columnID, cardViewModels: cardViewModels)
        columnTable.dataSource = columnTableDataSource
    }
}

extension CardListViewController: PlusButtonDelegate, CardCreatable {
    func showPlusCardViewController() {
        let plusCardViewController = CardViewController()
        plusCardViewController.columnID = column?.id
        plusCardViewController.delegate = self
        present(plusCardViewController, animated: true)
    }
    
    func cardDidCreate(_ card: Card) {
        columnTableDataSource.appendColumnModel(card: card)
        DispatchQueue.main.async {
            self.columnTable.reloadData()
        }
    }
}
