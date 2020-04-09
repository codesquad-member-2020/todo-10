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
        let deleteAction = UIContextualAction(style: .destructive, title: ButtonData.deleteString) {
            contextualAction, view, success in
            guard let dataSource = tableView.dataSource as? CardListTableDataSource
                else {
                    success(false)
                    return
            }
            dataSource.removeCardListModel(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            success(true)
        }
        return .init(actions: [deleteAction])
    }
}
