//
//  ViewModelBinding.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

protocol ViewModelBinding {
    associatedtype Key
    func updateNotify(changed handler: @escaping (Key) -> ())
}
