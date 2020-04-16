//
//  LogCell.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/16.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class LogCell: UITableViewCell, ReusableView {
    private let logContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContentLabel()
        configureTimeLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContentLabel()
        configureTimeLabel()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureContentLabel() {
        contentView.addSubview(logContentLabel)
        
        logContentLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        logContentLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
    }
    
    private func configureTimeLabel() {
        contentView.addSubview(timeLabel)
        
        timeLabel.topAnchor.constraint(equalTo: logContentLabel.bottomAnchor, constant: 10).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    func configureLogContent(text: String) {
        logContentLabel.text = text
    }
    
    func configureTime(text: String) {
        timeLabel.text = text
    }
}
