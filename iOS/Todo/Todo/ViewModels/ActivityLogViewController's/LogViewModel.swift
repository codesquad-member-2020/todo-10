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
    
    var content: String {
        switch log.action {
        case .added:
            return added
        case .removed:
            return removed
        case .updated:
            return updated
        case .moved:
            return moved
        }
    }
    
    private var added: String {
        if let destination = log.destination {
            return "\(log.action.description) \(title) to \(destination)"
        }
        return "\(log.action.description) \(title)"
    }
    
    private var removed: String {
        if let source = log.source {
            return "\(log.action.description) \(title) from \(source)"
        }
        return "\(log.action.description) \(title)"
    }
    
    private var updated: String {
        return "\(log.action.description) \(title)"
    }
    
    private var moved: String {
        if let source = log.source, let destination = log.destination {
            return "\(log.action.description) \(title) from \(source) to \(destination)"
        } else if let source = log.source {
            return "\(log.action.description) \(title) from \(source)"
        } else {
            return "\(log.action.description) \(title)"
        }
    }
    
    private var title: String {
        if let title = log.title {
            return title
        } else {
            let maxCount = 15
            if log.content.count > maxCount {
                let startIndex = log.content.startIndex
                let endIndex = log.content.index(startIndex, offsetBy: maxCount - 1)
                let abbreviatedContent = String(log.content[startIndex...endIndex])
                return "\(abbreviatedContent)..."
            } else {
                return log.content
            }
        }
    }
}
