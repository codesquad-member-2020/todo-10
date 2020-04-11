//
//  ContentView.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/11.
//  Copyright © 2020 Jason. All rights reserved.
//
import UIKit

final class ContentView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configureText()
        configureBorder()
        configureInsets()
        configurePlaceHolder()
    }
    
    private func configureText() {
        font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func configureBorder() {
        layer.borderWidth = 0.9
        layer.borderColor = UIColor.placeholderText.cgColor
        layer.cornerRadius = 13
    }
    
    private static let padding = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 0)
    private func configureInsets() {
        textContainerInset = ContentView.padding
    }
    
    func configurePlaceHolder() {
        text = ContentViewModel.placeHolderText
        textColor = .placeholderText
    }
    
    func configureTextWriting() {
        guard let first = text.first else { return }
        text = String(first)
        textColor = .black
    }
}
