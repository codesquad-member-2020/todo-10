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
        
        let constant: CGFloat = 8
        formatImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: constant).isActive = true
        formatImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: constant).isActive = true
    }
    
    private func configureTitle() {
        contentView.addSubview(titleLabel)
        
        let constant: CGFloat = 8
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: constant).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: formatImageView.trailingAnchor, constant: constant).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -constant).isActive = true
    }
    
    private func configureContext() {
        contentView.addSubview(contextLabel)
        
        let constant: CGFloat = 8
        contextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: constant).isActive = true
        contextLabel.leadingAnchor.constraint(equalTo: formatImageView.trailingAnchor, constant: constant).isActive = true
        contextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -constant).isActive = true
    }
    
    private func configureDetailText() {
        contentView.addSubview(authorLabel)
        
        let constant: CGFloat = 8
        authorLabel.topAnchor.constraint(equalTo: contextLabel.bottomAnchor, constant: constant).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: formatImageView.trailingAnchor, constant:  constant).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -constant).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -constant).isActive = true
    }
}
