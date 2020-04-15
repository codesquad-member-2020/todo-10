//
//  Response.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct ColumnsResponse: Codable {
    let status: Status
    let content: [Column]
}


struct Column: Codable {
    let id: Int
    let title: String
    let createDateTime: String
    let updateDateTime: String
    let cards: [Card]
}

struct Card: Codable {
    let id: Int
    var title: String?
    let content: String
    let createDateTime: String
    let updateDateTime: String
    let author: String
}
