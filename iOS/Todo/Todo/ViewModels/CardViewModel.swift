//
//  CardViewModel.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

final class CardViewModel: ViewModelBinding {
    typealias Key = CellModel?
    private var cellModel: Key
    private var changedHandler : (Key) -> ()
    
    init(cellModel: CellModel, changed handler: @escaping (Key) -> () = { _ in }) {
        self.changedHandler = handler
        self.cellModel = cellModel
        changedHandler(self.cellModel)
    }
    
    func bind(changed handler: @escaping (CellModel?) -> ()) {
        self.changedHandler = handler
        changedHandler(cellModel)
    }

    var cardListID: Int? {
        return cellModel?.cardListID
    }
    
    var cardID: Int? {
        return cellModel?.cardID
    }

}
