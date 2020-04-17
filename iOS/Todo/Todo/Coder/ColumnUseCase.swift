//
//  ColumnUseCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/17.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct ColumnUseCase {
    static func makeColumn(from string: String,
                           with manager: NetworkManagable,
                           completed: @escaping (Column?, LogID?) -> ()) {
        try? manager.requestResource(from: string, method: .delete, body: nil, format: Format.jsonType,
                                     headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) {
                                        (data, urlResponse, error) in
                                        guard error == nil, let data = data else { return }
                                        guard let cardResponse = try? JSONDecoder().decode(CardResponse.self, from: data) else { return }
                                        guard cardResponse.status == .success else { return }
                                        let logID = LogID(cardResponse.content.log_id)
                                        completed(Column(id: 100,
                                                         title: "^^",
                                                         createDateTime: "123",
                                                         updateDateTime: "1234", cards: []), logID)
        }
    }
}
