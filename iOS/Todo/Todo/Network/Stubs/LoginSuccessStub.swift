//
//  LoginSuccessStub.swift
//  Todo
//
//  Created by kimdo2297 on 2020/07/02.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct LoginSuccessStub: NetworkManagable {
    func requestResource(from urlString: String, method: HTTPMethod, body: Data?, format: String?, headers: [String]?, resultHandler: @escaping (Data?, URLResponse?, Error?) -> ()) throws {
        guard let data = Data.readJSON(for: "SuccessLoginResponseData") else { return }
        
        resultHandler(data, LoginHTTPURLResponseStub(), nil)
    }
}

final class LoginHTTPURLResponseStub: HTTPURLResponse {
    init() {
        super.init(
            url: URL(string: LoginUseCase.EndPoints.login)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Authorization": "fakeToken"]
            )!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

