//
//  CardCell.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class CardCell: UITableViewCell, ReusableView {
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
        configureImageView()
        configureTitle()
        configureContext()
        configureDetailText()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureImageView()
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
    
    private func configureImageView() {
        let textFormattingImage = UIImage(systemName: "text.justify")!
        imageView?.image = textFormattingImage
    }
    
    private func configureTitle() {
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        
        guard let imageView = imageView else { return }
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
    }
    
    private func configureContext() {
        contentView.addSubview(contextLabel)
        contextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        
        guard let imageView = imageView else { return }
        contextLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        contextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
    }
    
    private func configureDetailText() {
        contentView.addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: contextLabel.bottomAnchor, constant: 8).isActive = true
        
        guard let imageView = imageView else { return }
        authorLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant:  8).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        
        authorLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
    }
}
