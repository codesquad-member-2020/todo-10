//
//  CardListTableDataSource.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class CardListTableDataSource: NSObject {
    private var cardViewModels: [CardViewModel]
    
    init(cardViewModels: [CardViewModel]) {
        self.cardViewModels = cardViewModels
    }
    
    func removeCardListModel(at index: Int){
        guard index < cardViewModels.count else { return }
        cardViewModels.remove(at: index)
    }
    
    func cardListID(at index: Int) -> Int? {
        guard index < cardViewModels.count else { return nil }
        guard let cardListID = cardViewModels[index].cardListID else { return nil }
        return cardListID
    }
    
    func cardID(at index: Int) -> Int? {
        guard index < cardViewModels.count else { return nil }
        guard let cardID = cardViewModels[index].cardID else { return nil }
        return cardID
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
