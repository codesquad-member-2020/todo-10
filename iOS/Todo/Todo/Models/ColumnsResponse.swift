//
//  Response.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct ColumnsResponse: Codable {
    var status: Status
    var content: Content
}

struct Content: Codable {
    var sections: [Column]
    var logs: [Log]
}

struct Log: Codable {
    var action: String?
    var card: String?
    var source: String?
    var destination: String?
    var createdDateTime: String?
}


struct Column: Codable {
    let id: Int
    var title: String
    var cards: [Card]
}

struct Card: Codable {
    let id: Int
    var title: String?
    var content: String
    var createdDateTime: String
    var updatedDateTime: String
}
