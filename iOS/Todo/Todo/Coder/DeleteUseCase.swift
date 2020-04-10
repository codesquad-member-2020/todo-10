//
//  DeleteUseCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/09.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct DeleteUseCase {
    static func makeDeleteResponse(cardListID: Int,
                                   cardID: Int,
                                   with manager: NetworkManagable,
                                   result: @escaping (Bool?) -> ()) {
        try? manager.getResource(from: "\(NetworkManager.EndPoints.cardList)/\(cardListID)/card/\(cardID)",
            method: .delete,
            body: nil, format: Format.jsonType,
            headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) { (data, error) in
                guard error == nil, let data = data else { return }
                guard let cardResponse = try? JSONDecoder().decode(CardResponse.self, from: data) else { return }
                guard cardResponse.status == .success else { return }
                result(true)
        }
    }
}
