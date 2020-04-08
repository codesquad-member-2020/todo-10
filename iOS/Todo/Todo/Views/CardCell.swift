//
//  CardCell.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class CardCell: UITableViewCell, ReusableView {
    let formatImageView = FormatImageView(frame: .zero)
    let titleLabel = CardTitleLabel()
    let contextLabel = ContentLabel()
    let authorLabel = AuthorLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configure() {
        configureFormatImageView()
        configureTitle()
        configureContext()
        configureDetailText()
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

final class FormatImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(systemName: "text.justify")!
    }
}

final class CardTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        confugureText()
    }
    
    private func confugureText() {
        text = "Github 공부하기"
        font = UIFont.boldSystemFont(ofSize: 15)
    }
}

final class ContentLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configureText()
    }
    
    private func configureText() {
        lineBreakMode = .byWordWrapping
        numberOfLines = 3
        text = "contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimensionUITableView.automaticDimension"
    }
}

final class AuthorLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configureText()
    }
    
    private func configureText() {
        text = "author By iOS"
        font = UIFont.boldSystemFont(ofSize: 12)
    }
}
