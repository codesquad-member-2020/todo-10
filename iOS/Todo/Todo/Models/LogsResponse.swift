//
//  Logs.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/15.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct LogsResponse: Codable {
    let status: Status
    let content: [Log]
}

struct Log: Codable {
    let id: Int
    let user: String
    let action: Action
    let target: Target
    var title: String?
    let content: String
    var source: String?
    var destination: String?
    let createDateTime: Date
}

enum Action: String, Codable {
    case added = "ADDED"
    case removed = "REMOVED"
    case updated = "UPDATED"
    case moved = "MOVED"
}

enum Target: String, Codable {
    case column = "SECTION"
    case card = "CARD"
}
