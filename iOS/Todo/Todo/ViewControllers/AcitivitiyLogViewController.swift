//
//  AcitivitiyLogViewController.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class AcitivitiyLogViewController: UITableViewController {
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
    
    private var logViewModels = [LogViewModel]() {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func configureLogsCase() {
        LogsUseCase.makeLogs(with: NetworkManager()) { logViewModels in
            guard let logViewModels = logViewModels else { return }
            self.logViewModels = logViewModels
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let maxCount = 15
        let count = logViewModels.count < maxCount ? logViewModels.count : maxCount
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let logCell = tableView.dequeueReusableCell(withIdentifier: LogCell.reuseIdentifier) as? LogCell
            else { return LogCell() }
        let logViewModel = logViewModels[indexPath.row]
        logViewModel.performBind(changed: { log in
            logCell.configureUser(text: "@\(log.user)")
            logCell.configureTime(text: DateFormat.cardDateFormatter.string(from: log.createDateTime))
        })
        logCell.configureLogContent(text: logViewModel.content)
        return logCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Activities"
    }
}
