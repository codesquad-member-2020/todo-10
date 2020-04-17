//
//  EndPointFactory.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/14.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct EndPointFactory {
    enum EndPoints {
        static let column = "http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080/board/section"
        static let log = "http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080/board/log"
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
