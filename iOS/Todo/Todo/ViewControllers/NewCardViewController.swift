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
        guard let cardData = generateNewCard().encodeToJSONData() else { return }
        NewCardViewModelUseCase.makeNewCardViewModel(
            from: EndPointFactory.createNewCardURLString(columnID: columnID),
            cardData: cardData, with: MockCardCreateSuccessStub()) { cardViewModel, logID in
                guard let cardViewModel = cardViewModel else { return }
                self.delegate?.cardViewControllerDidCardCreate(cardViewModel)
                
                guard let logID = logID else { return }
                self.delegate?.cardViewControllerDidMake(logID: logID)
        }
        dismiss(animated: true, completion: nil)
    }
}
