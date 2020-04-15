//
//  EditingCardViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/14.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class EditingCardViewController: CardViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextColorWritingVersion()
    }
    
    @objc override func createCard() {
        guard let columnID = columnID else { return }
        guard let cardData = generateNewCard().encodeToJSONData() else { return }
        guard let cardID = cardViewModel?.cardID, let row = row else { return }
        let urlString = EndPointFactory.createExistedCardURLString(columnID: columnID, cardID: cardID)
        EditedCardViewModelUseCase.makeEditedCardViewModel(from: urlString, cardData: cardData,
                                                           with: MockCardEditSuccessStub()) { cardViewModel in
                                                            guard let cardViewModel = cardViewModel else { return }
                                                            self.delegate?.cardViewControllerDidCardEdit(cardViewModel,
                                                                                                         row: row)
        }
        dismiss(animated: true, completion: nil)
    }
    
    var row: Int?
    var cardViewModel: CardViewModel? {
        didSet {
            cardViewModel?.performBind(changed: { card in
                DispatchQueue.main.async {
                    self.configureTitle(text: card?.title)
                    self.configureContent(text: card?.content)
                }
            })
        }
    }
}
