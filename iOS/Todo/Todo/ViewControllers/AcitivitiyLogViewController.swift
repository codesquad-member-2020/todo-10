//
//  AcitivitiyLogViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class AcitivitiyLogViewController: UITableViewController {
    private var logViewModels: LogViewModels!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        configureLogsCase()
    }
    
    private func configureLogsCase() {
        LogsUseCase.makeLogs(with: NetworkManager()) { logViewModels in
            guard let logViewModels = logViewModels else { return }
            self.logViewModels = logViewModels
        }
    }
}
