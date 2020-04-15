//
//  Response.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

<<<<<<< HEAD:iOS/Todo/Todo/Models/Response.swift
struct Response: Codable {
=======
struct ColumnsResponse: Codable {
>>>>>>> dev:iOS/Todo/Todo/Models/ColumnsResponse.swift
    var status: Status
    var content: Content
}

struct Content: Codable {
<<<<<<< HEAD:iOS/Todo/Todo/Models/Response.swift
    var sections: [CardList]
=======
    var sections: [Column]
>>>>>>> dev:iOS/Todo/Todo/Models/ColumnsResponse.swift
    var logs: [Log]
}

struct Log: Codable {
    var action: String?
    var card: String?
    var source: String?
    var destination: String?
    var createdDateTime: String?
}

<<<<<<< HEAD:iOS/Todo/Todo/Models/Response.swift
struct CardList: Codable {
=======
struct Column: Codable {
>>>>>>> dev:iOS/Todo/Todo/Models/ColumnsResponse.swift
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
