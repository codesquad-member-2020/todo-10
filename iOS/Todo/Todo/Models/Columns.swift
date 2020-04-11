//
//  Section.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/09.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

protocol ColumnsDataSource {
    func iterateColumns(with handler: (CardList) -> ())
}

final class Columns: ColumnsDataSource {
    private let columns: [CardList]
    
    init(columns: [CardList]) {
        self.columns = columns
    }
    
    func iterateColumns(with handler: (CardList) -> ()) {
        columns.forEach { handler($0) }
    }
}
