//
//  NetworkManager.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

enum Format {
    static let jsonType = "application/json"
}

enum HTTPHeader {
    static let headerContentType = "Content-Type"
    static let headerAccept = "Accept"
}

enum HTTPMethod: String, CustomStringConvertible {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
    var description: String {
        return self.rawValue
    }
}

enum NetworkErrorCase: Error {
    case invalidURL
    case notFound
}

protocol NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                     resultHandler: @escaping (Data?, Error?) -> ()) throws
}

struct NetworkManager: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                     resultHandler: @escaping (Data?, Error?) -> ()) throws {
        guard let url = URL(string: urlString) else {
            throw NetworkErrorCase.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.description
        request.httpBody = body
        if let format = format, let headers = headers {
            headers.forEach {
                request.addValue(format, forHTTPHeaderField: $0)
            }
        }
        
        URLSession.shared.dataTask(with: request) {
            (data, repsonse, error) in
            resultHandler(data, error)
        }.resume()
    }
}

struct MockColumnsSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                     resultHandler: @escaping (Data?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successColumnsResponseStub, nil)
    }
}

struct MockLogsSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                     resultHandler: @escaping (Data?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successLogsResponseStub, nil)
    }
}

struct MockCardDeleteSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                     resultHandler: @escaping (Data?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successDeleteResponseStub, nil)
    }
}

struct MockCardCreateSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?, resultHandler: @escaping (Data?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successCreateResponseStub, nil)
    }
}

struct MockCardEditSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?, resultHandler: @escaping (Data?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successEditingResponseStub, nil)
    }
}
