//
//  ViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class ToDoViewController: UIViewController {
    enum SegueIdentifier: String {
        case toDo
        case inProgress
        case done
        
        func isValid(identifier: String?, completionHandler: () -> ()) {
            if identifier == self.rawValue {
                completionHandler()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        SegueIdentifier.toDo.isValid(identifier: segue.identifier) {
            guard let toDoViewController = segue.destination as? CardListController else { return }
            toDoViewController.setTitle(title: TitleLabel.Title.toDo)
        }
        SegueIdentifier.inProgress.isValid(identifier: segue.identifier) {
            guard let inProgressViewController = segue.destination as? CardListController else { return }
            inProgressViewController.setTitle(title: TitleLabel.Title.inProgress)
        }
        SegueIdentifier.done.isValid(identifier: segue.identifier) {
            guard let doneViewController = segue.destination as? CardListController else { return }
            doneViewController.setTitle(title: TitleLabel.Title.done)
        }
    }
}
