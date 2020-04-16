//
//  LogsDataSource.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/16.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

protocol LogsDataSource {
    func iterateLogs(with handler: (Log) -> ())
}

final class Logs: LogsDataSource {
    private let logs: [Log]
    
    init(logs: [Log]) {
        self.logs = logs
    }
    
    func iterateLogs(with handler: (Log) -> ()) {
        logs.forEach { handler($0) }
    }
}
