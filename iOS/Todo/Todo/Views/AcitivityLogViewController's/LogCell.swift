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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContentLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContentLabel()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureContentLabel() {
        addSubview(logContentLabel)
        
        logContentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        logContentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
    }
    
    func configureLogContent(text: String) {
        logContentLabel.text = text
    }
}
