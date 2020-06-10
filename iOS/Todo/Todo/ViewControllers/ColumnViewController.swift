//
//  ColumnViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

protocol ColumnViewControllerDelegate: class {
    func columnViewControllerDidMoveToDone(_ cardViewModel: CardViewModel)
    func columnViewControllerDidMove(sourceColumnID: Int, sourceRow: Int)
    func columnViewControllerDidMake(logID: LogID)
}

final class ColumnViewController: UIViewController {
    //MARK:- internal property
    private let titleView = TitleView()
    private var titleViewModel: TitleViewModel!
    private var columnTable = ColumnTable()
    private var columnTableDataSource: ColumnTableDataSource!
    weak var delegate: ColumnViewControllerDelegate?
    var columnID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDragAndDrop()
        configureTitleView()
        configureTableView()
        configureObservers()
    }
    
    private func configureDragAndDrop() {
        columnTable.dragInteractionEnabled = true
        columnTable.dragDelegate = self
        columnTable.dropDelegate = self
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
        titleView.configurePlusButton(delegate: self)
    }
    
    private func configureTableView() {
        columnTable.register(CardCell.self, forCellReuseIdentifier: CardCell.reuseIdentifier)
        columnTable.delegate = self
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
                                               selector: #selector(updateView),
                                               name: ColumnTableDataSource.Notification.cardViewModelsDidChange,
                                               object: columnTableDataSource)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureMoveUseCase),
                                               name: ColumnTableDataSource.Notification.cardViewModelDidMoveInSameColumn,
                                               object: columnTableDataSource)
    }
    
    @objc private func updateView() {
        DispatchQueue.main.async {
            self.updateBadge()
            self.columnTable.reloadData()
        }
    }
    
    @objc private func configureMoveUseCase(_ notification: NSNotification) {
        guard let columnID = columnID,
            let userInfo = notification.userInfo,
            let sourceIndexPath = userInfo["sourceIndexPath"] as? IndexPath,
            let destinationIndexPath = userInfo["destinationIndexPath"] as? IndexPath,
            let cardID = columnTableDataSource.cardViewModel(at: sourceIndexPath.row)?.cardID else { return }
        let urlString = EndPointFactory.createMoveLogURLString(columnID: columnID,
                                                         newColumnId: nil,
                                                         cardID: cardID,
                                                         newIndex: destinationIndexPath.row)
        MoveUseCase.requestMove(from: urlString,
                                with: NetworkManager()) { logID in
                                    guard let logID = logID else { return }
                                    self.columnTableDataSource.moveCardViewModel(at: sourceIndexPath.row,
                                                                                 to: destinationIndexPath.row)
                                    self.delegate?.columnViewControllerDidMake(logID: logID)
        }
    }
    
    private func updateBadge() {
        self.titleView.configureBadge(text: String(self.columnTableDataSource.cardViewModelsCount))
    }
    
    func configureTitleViewModel(column: Column) {
        titleViewModel = TitleViewModel(titleModel: TitleModel(title: column.title,
                                                               cardsCount: column.cards.count),
                                        changed: { titleModel in
                                            guard let titleModel = titleModel else { return }
                                            self.titleView.configureBadge(text: String(titleModel.cardsCount))
                                            self.titleView.configureTitleLabel(text: titleModel.title)
        })
    }
    
    func configureDataSource(column: Column) {
        let cardViewModels = column.cards.map { CardViewModel(card: $0)}
        columnTableDataSource = ColumnTableDataSource(cardViewModels: cardViewModels)
        columnTable.dataSource = columnTableDataSource
    }
    
    func insertToFirst(cardViewModel: CardViewModel) {
        columnTableDataSource.insert(cardViewModel: cardViewModel, at: 0)
    }
    
    func removeCardViewModel(row: Int) {
        columnTableDataSource.removeCardViewModel(at: row)
    }
}

extension ColumnViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            return self.contextMenu(tableView, for: indexPath)
        }
    }
    
    private func contextMenu(_ tableView: UITableView, for indexPath: IndexPath) -> UIMenu {
        return UIMenu(title: "", children: [moveToDone(tableView, for: indexPath),
                                            edit(tableView, for: indexPath),
                                            delete(tableView, for: indexPath)])
    }
    
    private func moveToDone(_ tableView: UITableView, for indexPath: IndexPath) -> UIAction {
        return UIAction(title: ButtonData.moveToDone) { action in
            self.moveRowToDone(tableView, for: indexPath)
        }
    }
    
    private func moveRowToDone(_ tableView: UITableView, for indexPath: IndexPath) {
        guard let cardViewModel = columnTableDataSource.cardViewModel(at: indexPath.row),
        let columnID = columnID, let cardID = cardViewModel.cardID else { return }
        let doneColumnID = 3
        let firstIndex = 0
        let urlString = EndPointFactory.createMoveLogURLString(columnID: columnID,
                                                               newColumnId: doneColumnID,
                                                               cardID: cardID,
                                                               newIndex: firstIndex)
        MoveUseCase.requestMove(from: urlString, with: NetworkManager()) { logID in
            guard let logID = logID else { return }
            self.delegate?.columnViewControllerDidMoveToDone(cardViewModel)
            self.columnTableDataSource.removeCardViewModel(at: indexPath.row)
            self.delegate?.columnViewControllerDidMake(logID: logID)
        }
    }
    
    private func edit(_ tableView: UITableView, for indexPath: IndexPath) -> UIAction {
        return UIAction(title: ButtonData.edit) { action in
            self.showEditingViewController(tableView, indexPath: indexPath)
        }
    }
    
    private func showEditingViewController(_ tableView: UITableView, indexPath: IndexPath) {
        guard let columnID = columnID ,
            let cardViewModel = columnTableDataSource.cardViewModel(at: indexPath.row) else { return }
        let editingCardViewController = EditingCardViewController()
        editingCardViewController.columnID = columnID
        editingCardViewController.delegate = self
        editingCardViewController.row = indexPath.row
        editingCardViewController.cardViewModel = cardViewModel
        present(editingCardViewController, animated: true)
    }
    
    private func delete(_ tableView: UITableView, for indexPath: IndexPath) -> UIAction {
        return UIAction(title: ButtonData.deleteString, attributes: .destructive) { action in
            let delayForNotOverlapped = 0.7
            self.deleteRow(tableView, for: indexPath, delay: delayForNotOverlapped)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions:
            [UIContextualAction(style: .destructive,
                                title: ButtonData.deleteString,
                                handler: { contextualAction, view, _ in
                                    self.deleteRow(tableView, for: indexPath)
            })])
    }
    
    private func deleteRow(_ tableView: UITableView, for indexPath: IndexPath,delay: Double = 0.0) {
        guard let cardViewModel = columnTableDataSource.cardViewModel(at: indexPath.row),
            let columnID = columnID,
            let cardID = cardViewModel.cardID else { return }
        let urlString = EndPointFactory.createExistedCardURLString(columnID: columnID, cardID: cardID)
        DeleteUseCase.requestDelete(from: urlString, with: NetworkManager()) { logID in
            guard let logID = logID else { return }
            self.columnTableDataSource.removeCardViewModel(at: indexPath.row)
            self.delegate?.columnViewControllerDidMake(logID: logID)
        }
    }
}

extension ColumnViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let columnID = columnID,
            let cardViewModel = columnTableDataSource.cardViewModel(at: indexPath.row),
            let cardID = cardViewModel.cardID else { return [] }
        
        let itemProvider = NSItemProvider()
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = DragObject(cardViewModel: cardViewModel,
                                          columnID: columnID,
                                          cardID: cardID,
                                          row: indexPath.row)
        return [dragItem]
    }
}

extension ColumnViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if tableView.hasActiveDrag {
            if session.items.count > 1 {
                return UITableViewDropProposal(operation: .cancel)
            } else {
                return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        } else {
            return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.items.forEach { item in
            guard let dragObject = item.dragItem.localObject as? DragObject,
                let columnID = columnID else { return }
            let urlString = EndPointFactory.createMoveLogURLString(columnID: dragObject.columnID,
                                                             newColumnId: columnID,
                                                             cardID: dragObject.cardID,
                                                             newIndex: destinationIndexPath.row)
            MoveUseCase.requestMove(from: urlString,
                                    with: NetworkManager()) { logID in
                                        guard let logID = logID else { return }
                                        self.delegate?.columnViewControllerDidMake(logID: logID)
                                        self.delegate?.columnViewControllerDidMove(sourceColumnID: dragObject.columnID,
                                                                                   sourceRow: dragObject.row)
                                        self.columnTableDataSource.insert(cardViewModel: dragObject.cardViewModel,
                                                                       at: destinationIndexPath.row)
            }
        }
    }
}

extension ColumnViewController: PlusButtonDelegate, CardViewControllerDelegate {
    func plusButtonDidTouch() {
        guard let columnID = columnID else { return }
        let newCardViewController = NewCardViewController()
        newCardViewController.columnID = columnID
        newCardViewController.delegate = self
        present(newCardViewController, animated: true)
    }
    
    func cardViewControllerDidMake(logID: LogID) {
        delegate?.columnViewControllerDidMake(logID: logID)
    }
    
    func cardViewControllerDidCardCreate(_ cardViewModel: CardViewModel) {
        columnTableDataSource.append(cardViewModel: cardViewModel)
    }
    
    func cardViewControllerDidCardEdit(_ cardViewModel: CardViewModel, row: Int) {
        columnTableDataSource.update(cardViewModel: cardViewModel, at: row)
    }
}
