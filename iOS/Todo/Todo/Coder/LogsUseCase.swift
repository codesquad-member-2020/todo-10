//
//  LogsUseCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/16.
//  Copyright © 2020 Jason. All rights reserved.
//
import UIKit

enum DateFormat {
    static let cardDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
}

struct LogsUseCase {
    
    enum EndPoints {
        static let logs = "http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080/board/logs"
    }
    
    static func makeLogs(with manager: NetworkManagable, completed: @escaping ([LogViewModel]?) -> ()) {
        try? manager.requestResource(from: EndPoints.logs, method: .get,
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
                                        guard let response = try? jsonDecoder.decode(LogsResponse.self, from: data) else { return }
                                        guard response.status == .success else { return }
                                        let logViewModels = response.content.map { LogViewModel(log: $0) }
                                        completed(logViewModels)
        }
    }
}
