//
//  EditingUseCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/13.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct EditedCardViewModelUseCase {
    static func makeEditedCardViewModel(columnID: Int, cardID: Int,
                                    cardData: Data,
                                    with manager: NetworkManagable,
                                    result: @escaping (CardViewModel?) -> () ) {
        try? manager.requestResource(from: "\(NetworkManager.EndPoints.column)/\(columnID)/card/\(cardID)",
            method: .patch,
            body: cardData, format: Format.jsonType,
            headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) { (data, error) in
                guard error == nil, let data = data else { return }
                guard let cardResponse = try? JSONDecoder().decode(CardResponse.self, from: data) else { return }
                guard cardResponse.status == .success else { return }
                result(CardViewModel(card: cardResponse.content))
        }
    }
}
