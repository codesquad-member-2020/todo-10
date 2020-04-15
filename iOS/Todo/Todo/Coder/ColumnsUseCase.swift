//
//  CardListsCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

enum LoginInfo {
    static let user = """
    {
        "name": "nigayo",
        "password": "1234"
    }
    """.data(using: .utf8)
}

struct ColumnsUseCase {
    enum EndPoints {
        static let columns = "http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080/board"
    }
    
    static func makeColumns(with manager: NetworkManagable, completed: @escaping (ColumnsDataSource?) -> ()) {
        try? manager.requestResource(from: EndPoints.columns, method: .get,
                                 body: nil, format: Format.jsonType,
                                 headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) { (data, error) in
                                    guard error == nil else { return }
                                    guard let data = data else { return }
                                    guard let response = try? JSONDecoder().decode(ColumnsResponse.self, from: data) else { return }
                                    guard response.status == .success else { return }
                                    
                                    let column = Columns(columns: response.content)
                                    completed(column)
        }
    }
}
