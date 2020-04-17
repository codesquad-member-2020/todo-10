//
//  ColumnUseCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/17.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct ColumnUseCase {
    static func makeColumn(body: Data,
                           with manager: NetworkManagable,
                           completed: @escaping (Column?, LogID?) -> ()) {
        try? manager.requestResource(from: EndPointFactory.EndPoints.column,
                                     method: .post, body: body, format: Format.jsonType,
                                     headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) {
                                        (data, urlResponse, error) in
                                        guard error == nil, let data = data else { return }
                                        guard let columnResponse = try? JSONDecoder().decode(ColumnResponse.self, from: data) else { return }
                                        guard columnResponse.status == .success else { return }
                                        let column = columnResponse.content.section
                                        let logID = LogID(columnResponse.content.log_id)
                                        completed(column, logID)
        }
    }
}

struct ColumnResponse: Codable {
    let status: Status
    let content: ColumnContent
}

struct ColumnContent: Codable {
    let log_id: Int
    let section: Column
}
