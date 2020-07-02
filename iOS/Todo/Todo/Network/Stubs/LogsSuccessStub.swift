//
//  LogsSuccessStub.swift
//  Todo
//
//  Created by kimdo2297 on 2020/07/02.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct LogsSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                         resultHandler: @escaping (Data?, URLResponse?, Error?) -> ()) throws {
        guard let data = Data.readJSON(for: "SuccessLogsResponseData") else { return }
        
        resultHandler(data, nil, nil)
    }
}
