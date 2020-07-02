//
//  ViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

enum Token {
    static var authorizationToken: String?
}

final class MainViewController: UIViewController {
    private let columScrollView = ColumnScrollView()
    private let activityLogViewController = AcitivitiyLogViewController()
    
    override func viewDidLoad() {
        configureScrollView()
        requestLogin { [weak self] result in
            guard let result = result, result else { return }
            self?.configureColumnsCase()
            self?.configureAcitivitiyLogViewController()
        }
    }
    
    private func configureScrollView() {
        view.addSubview(columScrollView)
        
        columScrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        columScrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        columScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        columScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    private func requestLogin(completed: @escaping (Bool?) -> ()) {
        LoginUseCase.makeToken(with: LoginSuccessStub()) { token in
            guard let token = token else { return }
            Token.authorizationToken = token
            completed(true)
        }
    }
    
    private func configureColumnsCase() {
        ColumnsUseCase.makeColumns(with: MockColumnsSuccessStub()) { columnsDataSource in
            guard let columnsDataSource = columnsDataSource else { return }
            columnsDataSource.iterateColumns(with: { column in
                self.addColumnViewController(column: column)
            })
        }
    }
    
    private func addColumnViewController(column: Column) {
        DispatchQueue.main.async {
            let columnViewController = self.columnViewController(column: column)
            self.addChild(columnViewController)
            self.columScrollView.addToStack(for: columnViewController.view)
            columnViewController.view.translatesAutoresizingMaskIntoConstraints = false
            columnViewController.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.32).isActive = true
            columnViewController.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
        }
    }
    
    private func columnViewController(column: Column) -> ColumnViewController {
        let columnViewController: ColumnViewController = {
            let controller = ColumnViewController()
            controller.configureTitleViewModel(column: column)
            controller.configureDataSource(column: column)
            controller.delegate = self
            controller.columnID = column.id
            return controller
        }()
        return columnViewController
    }
    
    private func configureAcitivitiyLogViewController() {
        DispatchQueue.main.async {
            self.addChild(self.activityLogViewController)
            self.view.addSubview(self.activityLogViewController.view)
            self.activityLogViewController.view.heightAnchor.constraint(equalTo: self.view.heightAnchor,
                                                                        multiplier: 0.8).isActive = true
            self.activityLogViewController.view.widthAnchor.constraint(equalTo: self.view.widthAnchor,
                                                                       multiplier: 0.28).isActive = true
            self.activityLogViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor,
                                                                     constant: 74).isActive = true
            self.activityLogViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                                          constant: -5).isActive = true
        }
    }
    
    private let dateProvider: () -> Date = Date.init
    @IBAction func menuButtonTouched(_ sender: UIBarButtonItem) {
        activityLogViewController.view.isHidden = !activityLogViewController.view.isHidden
        activityLogViewController.currentDate = dateProvider()
    }
}

extension MainViewController: ColumnViewControllerDelegate {
    func columnViewControllerDidMake(logID: LogID) {
        activityLogViewController.configureLogUseCase(for: logID)
    }
    
    func columnViewControllerDidMoveToDone(_ cardViewModel: CardViewModel) {
        let doneColumnID = 3
        DispatchQueue.main.async {
            self.children.forEach { viewController in
                guard let columnViewController = viewController as? ColumnViewController,
                    columnViewController.columnID == doneColumnID else { return }
                columnViewController.insertToFirst(cardViewModel: cardViewModel)
            }
        }
    }
    
    func columnViewControllerDidMove(sourceColumnID: Int, sourceRow: Int) {
        DispatchQueue.main.async {
            self.children.forEach { viewController in
                guard let columnViewController = viewController as? ColumnViewController,
                    let columnID = columnViewController.columnID,
                    columnID == sourceColumnID else { return }
                columnViewController.removeCardViewModel(row: sourceRow)
            }
        }
    }
}

extension MainViewController: NewColumnViewControllerDelegate, UIViewControllerTransitioningDelegate {
    func newColumnViewControllerDidCardCreate(column: Column) {
        addColumnViewController(column: column)
    }
    
    @IBAction func createColumnButtonTouched(_ sender: UIBarButtonItem) {
        guard Token.authorizationToken != nil else { return }
        let newColumnViewController = NewColumnViewController()
        newColumnViewController.delegate = self
        
        newColumnViewController.modalPresentationStyle = .custom
        newColumnViewController.transitioningDelegate = self
        
        self.present(newColumnViewController, animated: true)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}

final class HalfSizePresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let realCotainerView = containerView else { return .null }
        return CGRect(x: realCotainerView.bounds.width / 3,
                      y: realCotainerView.bounds.height / 3,
                      width: realCotainerView.bounds.width / 3,
                      height: realCotainerView.bounds.height / 2)
    }
}
