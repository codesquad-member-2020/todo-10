//
//  EndPointFactory.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/14.
//  Copyright © 2020 Jason. All rights reserved.
//

struct EndPointFactory {
    enum EndPoints {
        static let baseURL = "13.209.122.123/api"
        static let column = "http://\(Self.baseURL)/board/section"
        static let log = "http://\(Self.baseURL)/board/log"
    }
    
    static func createExistedCardURLString(columnID: Int, cardID: Int) -> String {
        return "\(EndPoints.column)/\(columnID)/card/\(cardID)"
    }
    
    static func createNewCardURLString(columnID: Int) -> String {
        return "\(EndPoints.column)/\(columnID)/card"
    }
    
    static func createLogURLString(logID: LogID) -> String {
        return "\(EndPoints.log)/\(logID.value)"
    }
    
    static func createMoveLogURLString(columnID: Int, newColumnId: Int?, cardID: Int, newIndex: Int) -> String {
        if newColumnId == nil {
            return "\(EndPoints.column)/\(columnID)/card/\(cardID)?cardTo=\(newIndex)"
        } else {
            return "\(EndPoints.column)/\(columnID)/card/\(cardID)?cardTo=\(newIndex)&sectionTo=\(newColumnId!)"
        }
    }
}
