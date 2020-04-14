//
//  NewCardViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/14.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class NewCardViewController: CardViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePlaceHolderVersion()
    }
    
    @objc override func createCard() {
        guard let columnID = columnID else { return }
        guard let content = contentView.text else { return }
        guard let cardData = try? JSONEncoder().encode(NewCard(title: titleField.text, content: content)) else { return }
        NewCardViewModelUseCase.makeNewCardViewModel(from: EndPointFactory.createNewCardURLString(columnID: columnID),
                                                     cardData: cardData, with: MockCardCreateSuccessStub()) { cardViewModel in
                                                        guard let cardViewModel = cardViewModel else { return }
                                                        self.delegate?.cardViewControllerDidCardCreate(cardViewModel)
        }
        dismiss(animated: true, completion: nil)
    }
}
