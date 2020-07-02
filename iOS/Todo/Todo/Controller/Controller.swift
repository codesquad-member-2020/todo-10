//
//  Controller.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//

final class Controller {
    static func isLengthNotZero(count: Int?) -> Bool {
        guard let count = count else { return  false }
        return count != 0
    }
}
