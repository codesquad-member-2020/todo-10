//
//  TitleViewModel.swift
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

final class TitleViewModel: ViewModelBinding {
    typealias Key = TitleModel?
    private var titleModel : Key = nil {
        didSet {
            changedHandler(titleModel)
        }
    }
    private var changedHandler : (Key) -> ()
    
    init(titleModel: TitleModel, changed handler: @escaping (Key) -> () = { _ in }) {
        self.changedHandler = handler
        self.titleModel = titleModel
        handler(titleModel)
    }
    
    func updateNotify(changed handler: @escaping (TitleModel?) -> ()) {
        self.changedHandler = handler
    }
}

