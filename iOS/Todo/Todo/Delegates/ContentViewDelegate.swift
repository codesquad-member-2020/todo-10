//
//  ContentViewDelegate.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class ContentViewDelegate: NSObject, UITextViewDelegate {
    private var isCorrectText = false
    
    var textLimit: Int {
        return 500
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textViewTextCount = textView.text?.count ?? 0
        let totalLength = textViewTextCount + text.count - range.length
        return totalLength <= textLimit
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        DispatchQueue.main.async {
            let firstPosition = textView.beginningOfDocument
            textView.selectedTextRange = textView.textRange(from: firstPosition, to: firstPosition)
        }
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if validIsCorrect(text: textView.text) {
            if !isCorrectText {
                isCorrectText = true
            }
        } else {
            if isCorrectText {
                isCorrectText = false
            }
        }
    }
    
    private func validIsCorrect(text: String?) -> Bool {
        return Controller.isLengthNotZero(count: text?.count)
    }
}
