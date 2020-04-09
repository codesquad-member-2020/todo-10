//
//  CellModel.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/09.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct CellModel {
    var cardListID: Int
    var cardID: Int
    var title: String?
    var content: String
    var createdDateTime: String
    var updatedDateTime: String
    
    init(cardListID: Int, card: Card) {
        self.cardListID = cardListID
        self.cardID = card.id
        self.title = card.title
        self.content = card.content
        self.createdDateTime = card.createdDateTime
        self.updatedDateTime = card.updatedDateTime
    }
}
