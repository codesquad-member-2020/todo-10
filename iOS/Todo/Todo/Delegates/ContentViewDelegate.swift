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
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        judgeCorrectText(textView.text)
    }
    
    private func judgeCorrectText(_ text: String?) {
        if Controller.isLengthZero(count: text?.count), isCorrectText {
            isCorrectText = false
        } else if !isCorrectText {
            isCorrectText = true
        }
    }
}
