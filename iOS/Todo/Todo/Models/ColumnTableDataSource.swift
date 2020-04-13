//
//  CardListTableDataSource.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//
import Foundation
import UIKit

final class ColumnTableDataSource: NSObject {
    let columnID: Int
    enum Notification {
        static let cardViewModelsDidChange = Foundation.Notification.Name("cardViewModelsDidChange")
    }
    private var cardViewModels: [CardViewModel] {
        didSet {
            NotificationCenter.default.post(name: Notification.cardViewModelsDidChange, object: self)
        }
    }
    
    var cardViewModelsCount: Int {
        return cardViewModels.count
    }
    
    init(columnID: Int, cardViewModels: [CardViewModel]) {
        self.columnID = columnID
        self.cardViewModels = cardViewModels
        super.init()
    }
    
    func removeColumnModel(at index: Int) {
        guard index < cardViewModels.count else { return }
        cardViewModels.remove(at: index)
    }
    
    func appendColumnModel(card: Card) {
        cardViewModels.append(CardViewModel(card: card))
    }
    
    func cardID(at index: Int) -> Int? {
        guard index < cardViewModels.count else { return nil }
        guard let cardID = cardViewModels[index].cardID else { return nil }
        return cardID
    }
}

extension ColumnTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cardCell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell else {
            fatalError("Unable to Dequeue \(CardCell.reuseIdentifier)")
        }
        
        let index = indexPath.row
        cardViewModels[index].performBind { card in
            cardCell.titleLabel.text = card?.title
            cardCell.contentLabel.text = card?.content
        }
        return cardCell
    }
}
