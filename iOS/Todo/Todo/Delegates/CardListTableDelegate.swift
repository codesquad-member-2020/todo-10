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
            guard let dataSource = tableView.dataSource as? CardListTableDataSource else { return }
            guard let cardID = dataSource.cardID(at: indexPath.row) else { return }
            DeleteUseCase.makeDeleteResponse(cardListID: dataSource.cardListID, cardID: cardID, with: NetworkManager()) { result in
                guard let result = result else { return }
                if result {
                    dataSource.removeCardListModel(at: indexPath.item)
                    DispatchQueue.main.async {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            }
        }
        return .init(actions: [deleteAction])
    }
}
