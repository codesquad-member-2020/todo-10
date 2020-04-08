//
//  CardViewModel.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

final class CardViewModel: ViewModelBinding {
    typealias Key = Card?
    private var card: Key = nil {
        didSet {
            changedHandler(card)
        }
    }
    private var changedHandler : (Key) -> ()
    
    init(card: Card, changed handler: @escaping (Key) -> () = { _ in }) {
        self.changedHandler = handler
        self.card = card
        changedHandler(card)
    }
    
    func bind(_ cardCell: CardCell) {
        guard let card = card else { return }
        cardCell.titleLabel.text = card.title
        cardCell.contentLabel.text = card.content
    }
    
    func updateNotify(changed handler: @escaping (Card?) -> ()) {
        self.changedHandler = handler
    }
}
