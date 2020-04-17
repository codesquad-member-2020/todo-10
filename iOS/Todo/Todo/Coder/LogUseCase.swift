//
//  LogUseCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/17.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct LogUseCase {
    static func makeLog(from string: String,
                         with manager: NetworkManagable,
                         completed: @escaping (LogViewModel?) -> ()) {
        try? manager.requestResource(from: string, method: .get,
                                     body: nil, format: Format.jsonType,
                                     headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) {
                                        (data, urlResponse, error) in
                                        guard error == nil else { return }
                                        guard let data = data else { return }
                                        let jsonDecoder: JSONDecoder = {
                                            let jsonDecoder = JSONDecoder()
                                            jsonDecoder.dateDecodingStrategy = .formatted(DateFormat.cardDateFormatter)
                                            return jsonDecoder
                                        }()
                                        guard let response = try? jsonDecoder.decode(LogResponse.self, from: data) else { return }
                                        guard response.status == .success else { return }
                                        let logViewModel = LogViewModel(log: response.content)
                                        completed(logViewModel)
        }
    }
}
