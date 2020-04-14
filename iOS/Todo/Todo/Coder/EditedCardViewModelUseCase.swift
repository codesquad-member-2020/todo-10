//
//  EditingUseCase.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/13.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct EditedCardViewModelUseCase {
    enum EndPoints {
        static let column = "http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080//mock/section"
    }
    static func makeEditedCardViewModel(columnID: Int, cardID: Int,
                                    cardData: Data,
                                    with manager: NetworkManagable,
                                    result: @escaping (CardViewModel?) -> () ) {
        try? manager.requestResource(from: "\(EndPoints.column)/\(columnID)/card/\(cardID)",
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
