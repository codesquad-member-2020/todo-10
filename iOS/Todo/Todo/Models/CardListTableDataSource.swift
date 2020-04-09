//
//  CardListTableDataSource.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class CardListTableDataSource: NSObject {
    private let cardViewModels: [CardViewModel]
    
    init(cardViewModels: [CardViewModel]) {
        self.cardViewModels = cardViewModels
    }
}

extension CardListTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cardCell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell else {
            fatalError("Unable to Dequeue \(CardCell.reuseIdentifier)")
        }
        
        let index = indexPath.row
        cardViewModels[index].bind { card in
            cardCell.titleLabel.text = card?.title
            cardCell.contentLabel.text = card?.content
        }
        return cardCell
    }
}
