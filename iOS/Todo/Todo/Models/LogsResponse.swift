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
    let action: String
    let target: String
    var title: String?
    let content: String
    var source: String?
    var destination: String?
    let createDateTime: Date
}
