//
//  CardResponse.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/09.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct CardResponse: Codable {
    let status: Status
    let content: Content
}

struct Content: Codable {
    let log_id: Int
    let card_count: Int
    var card: Card?
}
