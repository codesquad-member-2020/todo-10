//
//  TitleFieldDelegate.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class TitleFieldDelegate: NSObject, UITextFieldDelegate {
    static let placeHolderText = "Title"
    private(set) var isCorrect = false {
        didSet {
            if isCorrect != oldValue {
                NotificationCenter.default.post(name: Notification.isCorrectDidChange,
                                                object: self)
            }
        }
    }
    
    var textLimit: Int {
        return 10
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldTextCount = textField.text?.count ?? 0
        let totalLength = textFieldTextCount + string.count - range.length
        return totalLength <= textLimit
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if Controller.isLengthNotZero(count: text.count) {
            isCorrect = true
        } else {
            isCorrect = false
        }
    }
}
