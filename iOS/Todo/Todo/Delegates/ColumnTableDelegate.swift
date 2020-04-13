//
//  CardListTableDelegate.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//
import Foundation
import UIKit

final class ColumnTableDelegate: NSObject, UITableViewDelegate {
    enum Notification {
        static let menuDeleteEventOccured = Foundation.Notification.Name("contextMenuDeleteEventOccured")
        static let swipeDeleteEventOccured = Foundation.Notification.Name("swipeDeleteEventOccured")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions:
            [UIContextualAction(style: .destructive,
                                title: ButtonData.deleteString,
                                handler: { contextualAction, view, _ in
                                    self.notifySwipeDeleteEventOccured(indexPath: indexPath)
            })])
    }
    
    private func notifySwipeDeleteEventOccured(indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.swipeDeleteEventOccured, object: self, userInfo: ["indexPath" : indexPath])
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in 
            return self.contextMenu(tableView, for: indexPath)
        }
    }
}

extension ColumnTableDelegate {
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
        }
    }
}
