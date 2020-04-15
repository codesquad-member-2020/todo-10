//
//  Logs.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/15.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct LogsResponse: Codable {
    var status: Status
    var content: [Log]
}

struct Log: Codable {
    var id: Int
    var user: String
    var action: String
    var target: String
    var title: String
    var content: String
    var source: String?
    var destination: String?
    var createDateTime: String
}
