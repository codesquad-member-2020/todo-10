//
//  CardViewModels.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

final class CardViewModels {
    private let cardViewModels: [CardViewModel]
    
    init(_ cardViewModels: [CardViewModel]) {
        self.cardViewModels = cardViewModels
    }
    
    func bind(at index: Int, cardCell: CardCell) {
        guard index < cardViewModels.count else { return }
        cardViewModels[index].bind(cardCell)
    }

    var count: Int {
        return cardViewModels.count
    }
}
