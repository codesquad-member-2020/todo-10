//
//  CreateUseCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct NewCardViewModelUseCase {
    static func makeNewCardViewModel(from string: String,
                                     cardData: Data,
                                     with manager: NetworkManagable,
                                     completed: @escaping (CardViewModel?) -> ()) {
        try? manager.requestResource(from: string, method: .post,
            body: cardData, format: Format.jsonType,
            headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) { (data, error) in
                guard error == nil, let data = data else { return }
                guard let cardResponse = try? JSONDecoder().decode(CardResponse.self, from: data) else { return }
                guard let card = cardResponse.content.card else { return }
                guard cardResponse.status == .success else { return }
                
                completed(CardViewModel(card: card))
        }
    }
}
