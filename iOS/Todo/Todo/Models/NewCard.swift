//
//  NewCard.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/14.
//  Copyright © 2020 Jason. All rights reserved.
//
import Foundation

struct NewCard: Codable {
    let title: String?
    let content: String
    
    func encodeToJSONData() -> Data? {
        guard let newCardData = try? JSONEncoder().encode(self) else { return nil }
        return newCardData
    }
}
