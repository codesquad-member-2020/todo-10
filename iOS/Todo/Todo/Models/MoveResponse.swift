//
//  MoveResponse.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/17.
//  Copyright © 2020 Jason. All rights reserved.
//

struct MoveResponse: Codable {
    let status: Status
    let content: MoveContent
}

struct MoveContent: Codable {
    let log_id: Int
    let card_count_to_section: Int?
    let card_count_from_section: Int
}
