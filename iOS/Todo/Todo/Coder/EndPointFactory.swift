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
    }
    
    static func createExistedCardURLString(columnID: Int, cardID: Int) -> String {
        return "\(EndPoints.column)/\(columnID)/card/\(cardID)"
    }
    
    static func createNewCardURLString(columnID: Int) -> String {
        return "\(EndPoints.column)/\(columnID)/card"
    }
}
