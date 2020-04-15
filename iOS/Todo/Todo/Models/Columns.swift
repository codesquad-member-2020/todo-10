//
//  Section.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/09.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

protocol ColumnsDataSource {
    func iterateColumns(with handler: (Column) -> ())
}

final class Columns: ColumnsDataSource {
    private let columns: [Column]
    
    init(columns: [Column]) {
        self.columns = columns
    }
    
    func iterateColumns(with handler: (Column) -> ()) {
        columns.forEach { handler($0) }
    }
}
