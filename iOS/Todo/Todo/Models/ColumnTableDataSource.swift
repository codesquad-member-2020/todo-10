//
//  CardListTableDataSource.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//
import UIKit

final class ColumnTableDataSource: NSObject {
    enum Notification {
        static let cardViewModelsDidChange = Foundation.Notification.Name("cardViewModelsDidChange")
        static let cardViewModelDidMoveInSameColumn = Foundation.Notification.Name("cardViewModelDidMoveInSameColumn")
    }
    
    private var cardViewModels: [CardViewModel] {
        didSet { NotificationCenter.default.post(name: Notification.cardViewModelsDidChange,
                                                 object: self) }
    }
    
    init(cardViewModels: [CardViewModel]) {
        self.cardViewModels = cardViewModels
        super.init()
    }
    
    var cardViewModelsCount: Int {
        return cardViewModels.count
    }
    
    func removeCardViewModel(at index: Int) {
        guard index < cardViewModels.count else { return }
        cardViewModels.remove(at: index)
    }
    
    func cardViewModel(at index: Int) -> CardViewModel? {
        guard index < cardViewModels.count else { return nil }
        return cardViewModels[index]
    }
    
    func append(cardViewModel: CardViewModel) {
        cardViewModels.append(cardViewModel)
    }
    
    func update(cardViewModel: CardViewModel, at index: Int) {
        guard index < cardViewModels.count else { return }
        cardViewModels[index] = cardViewModel
    }
    
    func moveCardViewModel(at sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }
        
        let cardViewModel = cardViewModels[sourceIndex]
        cardViewModels.remove(at: sourceIndex)
        cardViewModels.insert(cardViewModel, at: destinationIndex)
    }
    
    func add(cardViewModel: CardViewModel, at index: Int) {
        cardViewModels.insert(cardViewModel, at: index)
    }
}

extension ColumnTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cardCell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseIdentifier,
                                                           for: indexPath) as? CardCell else {
                                                            return CardCell()
        }
        
        let index = indexPath.row
        cardViewModels[index].performBind { card in
            guard let card = card else { return }
            cardCell.configureTitle(text: card.title)
            cardCell.configureContent(text: card.content)
            cardCell.configureAuthor(text: "Added by \(card.author)")
        }
        return cardCell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.cardViewModelDidMoveInSameColumn,
                                        object: self)
    }
}
