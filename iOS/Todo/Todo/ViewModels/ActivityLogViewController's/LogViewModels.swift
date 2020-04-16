//
//  LogViewModels.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/16.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

final class LogViewModels {
    private var logViewModels = [LogViewModel]()
    
    init(logViewModels: [LogViewModel]) {
        self.logViewModels = logViewModels.reversed()
    }
    
    var count: Int {
        return logViewModels.count
    }
}

