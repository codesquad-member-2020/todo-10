//
//  ColumnViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit
final class ColumnViewController: UIViewController {
    //MARK:- internal property
    private let titleView = TitleView()
    private var titleViewModel: TitleViewModel!
    private var columnTable = ColumnTable()
    private var columnTableDataSource: ColumnTableDataSource!
    private var columnTableDelegate = ColumnTableDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleView()
        configureTableView()
        configureObservers()
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
    
    private func configureObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateBadge),
                                               name: ColumnTableDataSource.Notification.cardViewModelsDidChange,
                                               object: columnTableDataSource)
        NotificationCenter.default.addObserver(forName: ColumnTableDelegate.Notification.swipeDeleteEventOccured,
                                               object: columnTableDelegate,
                                               queue: nil) { notification in
                                                self.deleteRow(notification: notification)
        }
        NotificationCenter.default.addObserver(forName: ColumnTableDelegate.Notification.menuDeleteEventOccured,
                                               object: columnTableDelegate,
                                               queue: nil) { notification in
                                                self.deleteRow(notification: notification, delay: 0.7)
        }
        NotificationCenter.default.addObserver(forName: ColumnTableDelegate.Notification.menuEditEventOccured,
                                               object: columnTableDelegate,
                                               queue: nil) { notification in
                                                self.showEditingViewController(notification: notification)
        }
    }
    
    @objc private func updateBadge() {
        DispatchQueue.main.async {
            self.titleView.badge.text = String(self.columnTableDataSource.cardViewModelsCount)
        }
    }
    
    private func deleteRow(notification: Notification, delay: Double = 0.0) {
        guard let userInfo = notification.userInfo,
            let tableView = userInfo["tableView"] as? UITableView , let indexPath = userInfo["indexPath"] as? IndexPath,
            let cardViewModel = columnTableDataSource.cardViewModel(at: indexPath.row),
            let column = column, let cardID = cardViewModel.cardID else { return }
        DeleteUseCase.makeDeleteResult(columnID: column.id, cardID: cardID, with: MockCardDeleteSuccessStub()) { result in
            guard let result = result else { return }
            if result {
                self.columnTableDataSource.removeCardViewModel(at: indexPath.row)
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
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

extension ColumnViewController: PlusButtonDelegate, CardViewControllerDelegate {
    func plusButtonDidTouch() {
        let newCardViewController = NewCardViewController()
        newCardViewController.columnID = column?.id
        newCardViewController.delegate = self
        present(newCardViewController, animated: true)
    }
    
    private func showEditingViewController(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let indexPath = userInfo["indexPath"] as? IndexPath,
            let cardViewModel = columnTableDataSource.cardViewModel(at: indexPath.row) else { return }
        let editingCardViewController = EditingCardViewController()
        editingCardViewController.columnID = column?.id
        editingCardViewController.delegate = self
        editingCardViewController.willEditCardViewModel = WillEditCardViewModel(row: indexPath.row,
                                                                                cardViewModel: cardViewModel)
        present(editingCardViewController, animated: true)
    }
    
    func cardViewControllerDidCardCreate(_ cardViewModel: CardViewModel) {
        columnTableDataSource.append(cardViewModel: cardViewModel)
        DispatchQueue.main.async {
            self.columnTable.reloadData()
        }
    }
    
    func cardViewControllerDidCardEdit(_ willEditCardViewModel: WillEditCardViewModel) {
        columnTableDataSource.update(cardViewModel: willEditCardViewModel.cardViewModel,
                                     at: willEditCardViewModel.row)
        DispatchQueue.main.async {
            self.columnTable.reloadData()
        }
    }
}
