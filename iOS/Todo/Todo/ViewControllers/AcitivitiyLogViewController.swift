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
    
    var currentDate: Date? { didSet { updateView() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureView()
        configureLogsCase()
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(LogCell.self, forCellReuseIdentifier: LogCell.reuseIdentifier)
        tableView.dataSource = self
    }
    
    private func configureView() {
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor.opaqueSeparator.cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
    }
    
    private func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func configureLogsCase() {
        LogsUseCase.makeLogs(with: NetworkManager()) { logViewModels in
            guard let logViewModels = logViewModels else { return }
            self.logViewModels = LogViewModels(logViewModels: logViewModels.reversed())
        }
    }
    
    func configureLogUseCase(for logID: LogID) {
        let urlString = EndPointFactory.createLogURLString(logID: logID)
        LogUseCase.makeLog(from: urlString, with: NetworkManager()) { logViewModel in
            guard let logViewModel = logViewModel else { return }
            self.logViewModels.insertAtFirst(logViewModel: logViewModel)
        }
    }
}

extension AcitivitiyLogViewController {
    //MARK:- UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let logViewModels = logViewModels else { return 0 }
        let maxCount = 15
        let count = logViewModels.count < maxCount ? logViewModels.count : maxCount
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let logCell = tableView.dequeueReusableCell(withIdentifier: LogCell.reuseIdentifier) as? LogCell,
            let logViewModel = logViewModels.logViewModel(at: indexPath.row)
            else { return LogCell() }
        
        logViewModel.performBind(changed: { log in
            logCell.configureUser(text: "@\(log.user)")
        })
        
        logCell.configureTime(text: logViewModel.time(now: currentDate))
        logCell.configureLogContent(text: logViewModel.content)
        return logCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Activities"
    }
}
