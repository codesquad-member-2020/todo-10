//
//  CardCell.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class CardCell: UITableViewCell, ReusableView {
    let formatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "text.justify")!
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Github 공부하기"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "author By iOS"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    let contextLabel = ContextLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureFormatImageView()
        configureTitle()
        configureContext()
        configureDetailText()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureFormatImageView()
        configureTitle()
        configureContext()
        configureDetailText()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureFormatImageView() {
        contentView.addSubview(formatImageView)
        formatImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        formatImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
    }
    
    private func configureTitle() {
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: formatImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
    }
    
    private func configureContext() {
        contentView.addSubview(contextLabel)
        contextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        contextLabel.leadingAnchor.constraint(equalTo: formatImageView.trailingAnchor, constant: 8).isActive = true
        contextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
    }
    
    private func configureDetailText() {
        contentView.addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: contextLabel.bottomAnchor, constant: 8).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: formatImageView.trailingAnchor, constant:  8).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
    }
}
