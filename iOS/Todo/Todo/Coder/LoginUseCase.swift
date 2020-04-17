//
//  LoginUseCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/15.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct LoginUseCase {
    enum LoginInfo {
        static let user = """
        {
            "name": "nigayo",
            "password": "1234"
        }
        """.data(using: .utf8)
    }
    
    enum EndPoints {
        static let login = "http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080/board/login"
    }
    
    static func makeToken(with manager: NetworkManagable, completed: @escaping (String?) -> ()) {
        try? manager.requestResource(from: EndPoints.login, method: .post,
                                     body: LoginInfo.user, format: Format.jsonType,
                                     headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) {
                                        (data, urlResponse, error) in
                                        guard error == nil else { return }
                                        guard let data = data else { return }
                                        guard let response = try? JSONDecoder().decode(LoginResponse.self, from: data) else { return }
                                        guard response.status == .success else { return }
                                        guard let httpResponse = urlResponse as? HTTPURLResponse else { return }
                                        guard let token = httpResponse.allHeaderFields["Authorization"] as? String else { return }
                                                                                
                                        completed(token)
        }
    }
}
