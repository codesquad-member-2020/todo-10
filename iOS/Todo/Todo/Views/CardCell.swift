//
//  CardCell.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class CardCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImageView()
        configureText()
        configureDetailText()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureImageView()
        configureText()
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
    
    private func configureText() {
        textLabel?.text = "Github 공부하기"
        textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    private func configureDetailText() {
        detailTextLabel?.text = "author By iOS"
    }
}
