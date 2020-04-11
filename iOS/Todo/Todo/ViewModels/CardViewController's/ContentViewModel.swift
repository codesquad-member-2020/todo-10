//
//  ContentViewModel.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

final class ContentViewModel: ViewModelBinding {
    typealias Key = String

    static let placeHolderText = "Add a message what to do"
    
    func performBind(changed handler: @escaping (String) -> ()) {
        
    }
}
