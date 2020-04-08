//
//  ViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    private let cardListViewControllers = [CardListController(), CardListController(), CardListController(), CardListController(), CardListController()]
    private let scrollView = CardListScrollView()
    private let networkManager = NetworkManager()
    override func viewDidLoad() {
        configureScrollView()
        configureCardLists()
        guard let body = """
        {
            "email": "nigayo@ggmail.com",
            "password": "1234"
        }
        """.data(using: .utf8) else { return }
        
        try? networkManager.getResource(from: NetworkManager.EndPoints.cardLists, method: .post,
                                        body: body, format: Format.jsonType,
                                        headers: [HTTPHeader.headerContentType, HTTPHeader.headerAccept]) { (data, error) in
                                            guard error == nil else { return }
                                            guard let data = data else { return }
                                            guard let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return }
                                            print(prettyPrintedString)
        }
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    private func configureCardLists() {
        cardListViewControllers.forEach {
            addChild($0)
            scrollView.stackView.addArrangedSubview($0.view)
            $0.view.translatesAutoresizingMaskIntoConstraints = false
            $0.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.32).isActive = true
            $0.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        }
    }
}
