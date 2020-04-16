//
//  LogViewModel.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/16.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

final class LogViewModel: ViewModelBinding {
    typealias Key = Log
    private var log: Key
    private var changedHandler : (Key) -> ()
    
    init(log: Log, changed handler: @escaping (Key) -> () = { _ in }) {
        self.changedHandler = handler
        self.log = log
        changedHandler(self.log)
    }
    
    func performBind(changed handler: @escaping (Log) -> ()) {
        self.changedHandler = handler
        changedHandler(log)
    }
}
