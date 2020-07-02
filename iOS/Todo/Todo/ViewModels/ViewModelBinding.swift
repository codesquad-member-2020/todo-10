//
//  ViewModelBinding.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

protocol ViewModelBinding {
    associatedtype Key
    func performBind(changed handler: @escaping (Key) -> ()) 
}
