//
//  DeleteUseCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/09.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct DeleteUseCase {
    static func requestDelete(from string: String,
                                 with manager: NetworkManagable,
                                 result: @escaping (Bool?) -> ()) {
        try? manager.requestResource(from: string, method: .delete, body: nil, format: Format.jsonType,
                                     headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) { (data, error) in
                                        guard error == nil, let data = data else { return }
                                        guard let cardResponse = try? JSONDecoder().decode(CardResponse.self, from: data) else { return }
                                        guard cardResponse.status == .success else { return }
                                        
                                        result(true)
        }
    }
}
