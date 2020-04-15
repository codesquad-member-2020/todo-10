//
//  CardResponse.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/09.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct DeleteResponse: Codable {
    let status: Status
    let content: String
}

struct CardResponse: Codable {
    let status: Status
    let content: Card
}
