//
//  ContentViewDelegate.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//
import UIKit

final class ContentViewDelegate: NSObject, UITextViewDelegate {
    static let placeHolderText = "Add a message what to do"
    enum Notification {
        static let isCorrectDidChange = Foundation.Notification.Name("isCorrectDidChange")
    }
    private(set) var isCorrect = false {
        didSet {
            if isCorrect != oldValue {
                NotificationCenter.default.post(name: Notification.isCorrectDidChange,
                                                object: self)
            }
        }
    }
    
    var textLimit: Int {
        return 500
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textViewTextCount = textView.text?.count ?? 0
        let totalLength = textViewTextCount + text.count - range.length
        return totalLength <= textLimit
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.text.contains(Self.placeHolderText) else { return }
        setPositionBeginningOfDocument(textView)
    }

    private func setPositionBeginningOfDocument(_ textView: UITextView) {
        DispatchQueue.main.async {
            let firstPosition = textView.beginningOfDocument
            textView.selectedTextRange = textView.textRange(from: firstPosition, to: firstPosition)
        }
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if isContainsPlaceHolderButNotSame(text: textView.text) {
            guard let contentView = textView as? ContentView else { return }
            contentView.configureTextWriting()
            textViewDidChangeSelection(textView)
        } else if isValid(text: textView.text) {
            isCorrect = true
        } else {
            guard let contentView = textView as? ContentView else { return }
            contentView.configurePlaceHolderVersion()
            setPositionBeginningOfDocument(textView)
            isCorrect = false
        }
    }
    
    private func isContainsPlaceHolderButNotSame(text: String?) -> Bool {
        guard let text = text else { return false }
        guard text != Self.placeHolderText,
            text.contains(Self.placeHolderText) else { return false }
        return true
    }
    
    private func isValid(text: String?) -> Bool {
        guard let text = text else { return false }
        guard text != Self.placeHolderText,
            Controller.isLengthNotZero(count: text.count) else { return false }
        return true
    }
}
