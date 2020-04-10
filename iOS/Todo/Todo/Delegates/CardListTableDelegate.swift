//
//  CardListTableDelegate.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class CardListTableDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions:
            [UIContextualAction(style: .destructive,
                                title: ButtonData.deleteString,
                                handler: { contextualAction, view, _ in
                                    self.deleteRow(tableView, indexPath: indexPath)
            })])
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in 
            return self.contextMenu(tableView, for: indexPath)
        }
    }
}

extension CardListTableDelegate {
    private func deleteRow(_ tableView: UITableView, indexPath: IndexPath, resultHandler: @escaping (Bool?) -> () = { _ in }) {
        guard let dataSource = tableView.dataSource as? CardListTableDataSource else { return }
        guard let cardID = dataSource.cardID(at: indexPath.row) else { return }
        DeleteUseCase.makeDeleteResponse(cardListID: dataSource.cardListID,
                                         cardID: cardID,
                                         with: NetworkManager()) { result in
                                            guard let result = result else { return }
                                            if result {
                                                dataSource.removeCardListModel(at: indexPath.row)
                                                DispatchQueue.main.async {
                                                    tableView.deleteRows(at: [indexPath], with: .fade)
                                                }
                                                resultHandler(true)
                                            }
        }
    }
    
    private func contextMenu(_ tableView: UITableView, for indexPath: IndexPath) -> UIMenu {
        return UIMenu(title: "", children: [move(), edit(), delete(tableView, for: indexPath)])
    }
    
    private func move() -> UIAction {
        return UIAction(title: ButtonData.moveToDone) { action in
            
        }
    }
    
    private func edit() -> UIAction {
        return UIAction(title: ButtonData.edit) { action in
            
        }
    }
    
    private func delete(_ tableView: UITableView,for indexPath: IndexPath) -> UIAction {
        return UIAction(title: ButtonData.deleteString, attributes: .destructive) { action in
            self.deleteRow(tableView, indexPath: indexPath)
        }
    }
}
