//
//  TitleFieldDelegate.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class TitleFieldDelegate: NSObject, UITextFieldDelegate {
    private var isCorrectText = false
    
    var textLimit: Int {
        return 25
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldTextCount = textField.text?.count ?? 0
        let totalLength = textFieldTextCount + string.count - range.length
        return totalLength <= textLimit
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        judgeCorrectText(textField.text)
    }
    
    private func judgeCorrectText(_ text: String?) {
        if Controller.isLengthZero(count: text?.count), isCorrectText {
            isCorrectText = false
        } else if !isCorrectText {
            isCorrectText = true
        }
    }
}
