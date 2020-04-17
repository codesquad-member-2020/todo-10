//
//  LogViewModels.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/17.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

final class LogViewModels {
    enum Notification {
        static let logViewModelsDidChange = Foundation.Notification.Name("logViewModelsDidChange")
    }
    private var logViewModels: [LogViewModel]
    
    init(logViewModels: [LogViewModel]) {
        self.logViewModels = logViewModels
        NotificationCenter.default.post(name: Notification.logViewModelsDidChange,
                                        object: self)
    }
    
    var count: Int {
        return logViewModels.count
    }
    
    func logViewModel(at index: Int) -> LogViewModel?{
        guard index < count else { return nil }
        return logViewModels[index]
    }
    
    func insertAtFirst(logViewModel: LogViewModel) {
        logViewModels.insert(logViewModel, at: 0)
    }
}
