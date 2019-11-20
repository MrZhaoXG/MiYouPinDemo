//
//  MenuCell.swift
//  MiYouPin
//
//  Created by 赵锡光 on 2019/11/17.
//  Copyright © 2019 Mr.Zhao. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    var info: MenuInfo!
    var label: UILabel!
    var imageView: UIImageView!
    func configure() {
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = info.title
        label.textAlignment = .right
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        contentView.addSubview(label)
        imageView = UIImageView()
        contentView.addSubview(imageView)
        imageView.image = info.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let inset: CGFloat = 5
        
        NSLayoutConstraint.activate([imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
                                     imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
                                     imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
                                     imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -inset),
                                     imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)])
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: inset),
                                     label.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
}
