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
    private let titleField = TitleField()
    private let titleFieldDelegate = TitleFieldDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCreateButton()
        configureCancelButton()
        configureObserver()
        configureTitleField()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor.opaqueSeparator.cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
    }
    
    private func configureCreateButton() {
        createButton.isEnabled = true
        createButton.addTarget(self, action: #selector(createColumn), for: .touchUpInside)
        
        view.addSubview(createButton)
        let constant: CGFloat = 27
        createButton.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
    }
    
    @objc private func createColumn() {
        guard let text = titleField.text else { return }
        guard let data = Title(value: text).encodeToJSONData() else { return }
        ColumnUseCase.makeColumn(body: data, with: NetworkManager()) { (column, logID) in
            guard let column = column else { return }
            self.delegate?.newColumnViewControllerDidCardCreate(column: column)
            
            guard let logID = logID else { return }
            self.delegate?.columnViewControllerDidMake(logID: logID)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func configureCancelButton() {
        cancelButton.addTarget(self, action: #selector(dismissCardViewController), for: .touchUpInside)
        
        view.addSubview(cancelButton)
        let constant: CGFloat = 27
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: createButton.leadingAnchor, constant: -constant).isActive = true
    }
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCreateButton),
                                               name: Notification.isCorrectDidChange,
                                               object: titleFieldDelegate)
    }
    
    @objc private func updateCreateButton() {
        if titleFieldDelegate.isCorrect {
            createButton.configureEnable()
        } else {
            createButton.configureDisable()
        }
    }
    
    
    private func configureTitleField() {
        titleField.delegate = titleFieldDelegate
        
        view.addSubview(titleField)
        let constant: CGFloat = 27
        titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        titleField.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: constant).isActive = true
        titleField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    @objc private func dismissCardViewController() {
        dismiss(animated: true, completion: nil)
    }
}

struct Title: Codable {
    let title: String
    
    init(value: String) {
        self.title = value
    }
    
    func encodeToJSONData() -> Data? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return data
    }
}
