//
//  MoveUseCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/17.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct MoveUseCase {
    static func requestMove(from string: String,
                            with manager: NetworkManagable,
                            completed: @escaping (LogID?) -> ()) {
        try? manager.requestResource(from: string, method: .put, body: nil, format: Format.jsonType,
                                     headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) {
                                        (data, urlResponse, error) in
                                        guard error == nil, let data = data else { return }
                                        guard let moveResponse = try? JSONDecoder().decode(MoveResponse.self, from: data) else { return }
                                        guard moveResponse.status == .success else { return }
                                        let logID = LogID(moveResponse.content.log_id)
                                        completed(logID)
        }
    }
}
