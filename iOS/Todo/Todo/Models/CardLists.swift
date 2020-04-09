//
//  Section.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/09.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

protocol CardListsDataSource {
    func iterateCardList(with handler: (CardList) -> ())
}

final class CardLists: CardListsDataSource {
    private let cardLists: [CardList]
    
    init(cardLists: [CardList]) {
        self.cardLists = cardLists
    }
    
    func iterateCardList(with handler: (CardList) -> ()) {
        cardLists.forEach { handler($0) }
    }
}
