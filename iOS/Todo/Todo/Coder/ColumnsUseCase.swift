//
//  CardListsCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct ColumnsUseCase {
    enum EndPoints {
        static let columns = "http://\(EndPointFactory.EndPoints.baseURL)/board"
    }
    
    static func makeColumns(with manager: NetworkManagable, completed: @escaping (ColumnsDataSource?) -> ()) {
        try? manager.requestResource(from: EndPoints.columns, method: .get,
                                     body: nil, format: Format.jsonType,
                                     headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) {
                                        (data, urlResponse, error) in
                                        guard error == nil else { return }
                                        guard let data = data else { return }
                                        guard let response = try? JSONDecoder().decode(ColumnsResponse.self, from: data) else { return }
                                        guard response.status == .success else { return }
                                        
                                        let column = Columns(columns: response.content)
                                        completed(column)
        }
    }
}
