//
//  CreateUseCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct NewCard: Codable {
    let title: String?
    let content: String
}

struct NewCardViewModelUseCase {
    static func makeNewCardViewModel(columnID: Int,
                                   cardData: Data,
                                   with manager: NetworkManagable,
                                   result: @escaping (CardViewModel?) -> ()) {
        try? manager.requestResource(from: "\(NetworkManager.EndPoints.column)/\(columnID)/card",
            method: .post,
            body: cardData, format: Format.jsonType,
            headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) { (data, error) in
                guard error == nil, let data = data else { return }
                guard let cardResponse = try? JSONDecoder().decode(CardResponse.self, from: data) else { return }
                guard cardResponse.status == .success else { return }
                result(CardViewModel(card: cardResponse.content))
        }
    }
}
