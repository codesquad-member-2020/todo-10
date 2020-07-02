//
//  CardViewModel.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

final class CardViewModel: ViewModelBinding {
    typealias Key = Card?
    private var card: Key
    private var changedHandler : (Key) -> ()
    
    init(card: Card, changed handler: @escaping (Key) -> () = { _ in }) {
        self.changedHandler = handler
        self.card = card
        changedHandler(self.card)
    }
    
    func performBind(changed handler: @escaping (Key) -> ()) {
        self.changedHandler = handler
        changedHandler(card)
    }

    var cardID: Int? {
        return card?.id
    }
}
