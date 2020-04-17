//
//  NewColumnViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/17.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

protocol NewColumnViewControllerDelegate {
    func newColumnViewControllerDidCardCreate(column: Column)
    func columnViewControllerDidMake(logID: LogID)
}

final class NewColumnViewController: UIViewController {
    var delegate: NewColumnViewControllerDelegate?
    private let cancelButton = CancelButton()
    private let createButton = CreateButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCancelButton()
        configureCreateButton()
    }
    
    private func configureCreateButton() {
        createButton.addTarget(self, action: #selector(createColumn), for: .touchUpInside)
        
        view.addSubview(createButton)
        let constant: CGFloat = 27
        createButton.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
    }
    
    @objc private func createColumn() {
        ColumnUseCase.makeColumn(from: "temp", with: NetworkManager()) { (column, logID) in
            guard let column = column else { return }
            self.delegate?.newColumnViewControllerDidCardCreate(column: column)
            
            guard let logID = logID else { return }
            self.delegate?.columnViewControllerDidMake(logID: logID)
        }
    }
    
    private func configureCancelButton() {
        cancelButton.addTarget(self, action: #selector(dismissCardViewController), for: .touchUpInside)
        
        view.addSubview(cancelButton)
        let constant: CGFloat = 27
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: createButton.leadingAnchor, constant: -constant).isActive = true
    }
    
    @objc private func dismissCardViewController() {
        dismiss(animated: true, completion: nil)
    }
}

