//
//  ContentViewDelegate.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class ContentViewDelegate: NSObject, UITextViewDelegate {
    private var isCorrect = false
    
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
        if isContainsPlaceHolderButNotSame(text: textView.text) {
            guard let contentView = textView as? ContentView else { return }
            contentView.configureTextWriting()
        } else if isValid(text: textView.text) {
            if !isCorrect {
                isCorrect = true
            }
        } else {
            if isCorrect {
                guard let contentView = textView as? ContentView else { return }
                contentView.configurePlaceHolder()
                isCorrect = false
            }
        }
    }
    
    private func isContainsPlaceHolderButNotSame(text: String?) -> Bool {
        guard let text = text else { return false }
        guard text != ContentViewModel.placeHolderText,
            text.contains(ContentViewModel.placeHolderText) else { return false }
        return true
    }
    
    private func isValid(text: String?) -> Bool {
        guard let text = text else { return false }
        guard text != ContentViewModel.placeHolderText,
            Controller.isLengthNotZero(count: text.count) else { return false }
        return true
    }
}
