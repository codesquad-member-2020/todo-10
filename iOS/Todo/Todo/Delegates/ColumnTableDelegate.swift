//
//  CardListTableDelegate.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class ColumnTableDelegate: NSObject, UITableViewDelegate {
    override init() {
        super.init()
    }
    
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

extension ColumnTableDelegate {
    private func deleteRow(_ tableView: UITableView, indexPath: IndexPath, delay: Double = 0.0, resultHandler: @escaping (Bool?) -> () = { _ in }) {
        guard let dataSource = tableView.dataSource as? ColumnTableDataSource else { return }
        guard let cardID = dataSource.cardID(at: indexPath.row) else { return }
        DeleteUseCase.makeDeleteResponse(columnID: dataSource.columnID,
                                         cardID: cardID,
                                         with: MockCardDeleteSuccessStub()) { result in
                                            guard let result = result else { return }
                                            if result {
                                                dataSource.removeColumnModel(at: indexPath.row)
                                                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
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
            let delayForNotOverlapAnimation = 0.7
            self.deleteRow(tableView, indexPath: indexPath, delay: delayForNotOverlapAnimation)
        }
    }
}
