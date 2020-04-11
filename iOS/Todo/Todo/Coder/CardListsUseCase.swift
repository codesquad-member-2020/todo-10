//
//  CardListsCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

enum LoginInfo {
    static let cardLists = """
    {
        "email": "nigayo@ggmail.com",
        "password": "1234"
    }
    """.data(using: .utf8)
}

struct CardListsUseCase {
    static func makeCardLists(with manager: NetworkManagable, completed: @escaping (CardListsDataSource?) -> ()) {
        try? manager.requestResource(from: NetworkManager.EndPoints.cardLists, method: .post,
                                 body: LoginInfo.cardLists, format: Format.jsonType,
                                 headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) { (data, error) in
                                    guard error == nil else { return }
                                    guard let data = data else { return }
                                    guard let response = try? JSONDecoder().decode(CardListsResponse.self, from: data) else { return }
                                    guard response.status == .success else { return }
                                    let cardList = CardLists(cardLists: response.content.sections)
                                    completed(cardList)
        }
    }
}
