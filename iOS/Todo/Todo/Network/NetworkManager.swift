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
                     resultHandler: @escaping (Data?, URLResponse?, Error?) -> ()) throws
}

struct NetworkManager: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                     resultHandler: @escaping (Data?, URLResponse?, Error?) -> ()) throws {
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
        if let authorizationToken = Token.authorizationToken {
            request.addValue(authorizationToken, forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) {
            (data, urlRepsonse, error) in
            resultHandler(data, urlRepsonse, error)
        }.resume()
    }
}

struct MockColumnsSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                     resultHandler: @escaping (Data?, URLResponse?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successColumnsResponseStub, nil, nil)
    }
}

struct MockLogsSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                     resultHandler: @escaping (Data?, URLResponse?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successLogsResponseStub, nil, nil)
    }
}

struct MockCardDeleteSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?,
                     resultHandler: @escaping (Data?, URLResponse?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successDeleteResponseStub, nil, nil)
    }
}

struct MockCardCreateSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?, resultHandler: @escaping (Data?, URLResponse?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successCreateResponseStub, nil, nil)
    }
}

struct MockCardEditSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?, resultHandler: @escaping (Data?, URLResponse?, Error?) -> ()) throws {
        resultHandler(StubJsonData.successEditingResponseStub, nil, nil)
    }
}
