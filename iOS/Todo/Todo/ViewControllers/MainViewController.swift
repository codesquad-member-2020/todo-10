//
//  ViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    private let columScrollView = ColumnScrollView()
    
    override func viewDidLoad() {
        configureScrollView()
        configureColumnsCase()
    }
    
    private func configureScrollView() {
        view.addSubview(columScrollView)
        
        columScrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        columScrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        columScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        columScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    private func configureColumnsCase() {
        ColumnsUseCase.makeColumns(with: MockColumnsSuccessStub()) { columnsDataSource in
            columnsDataSource?.iterateColumns(with: { column in
                DispatchQueue.main.async {
                    self.addColumnViewController(columnViewController: self.columnViewController(column: column))
                }
            })
        }
    }
    
    private func columnViewController(column: Column) -> ColumnViewController {
        let columnViewController: ColumnViewController = {
            let controller = ColumnViewController()
            controller.configureTitleViewModel(column: column)
            controller.configureDataSource(column: column)
            controller.columnID = column.id
            return controller
        }()
        return columnViewController
    }
    
    private func addColumnViewController(columnViewController: ColumnViewController) {
        addChild(columnViewController)
        columScrollView.columnStackView.addArrangedSubview(columnViewController.view)
        columnViewController.view.translatesAutoresizingMaskIntoConstraints = false
        columnViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.32).isActive = true
        columnViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
    }
}
