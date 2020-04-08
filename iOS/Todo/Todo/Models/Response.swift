//
//  Response.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct Response: Codable {
    var status: String?
    var content: Content?
}

struct Content: Codable {
    var sections: [Section]?
    var logs: [Log]?
}

struct Log: Codable {
    var action: String?
    var card: String?
    var source: String?
    var destination: String?
    var createdDateTime: String?
}

struct Section: Codable {
    var id: String?
    var title: String?
    var cards: [Card]?
}

struct Card: Codable {
    var id: String?
    var title: String?
    var content: String?
}



