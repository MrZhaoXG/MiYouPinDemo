//
//  Section2Cell.swift
//  MiYouPin
//
//  Created by 赵锡光 on 2019/11/19.
//  Copyright © 2019 Mr.Zhao. All rights reserved.
//

import UIKit

class Section2Cell: UICollectionViewCell {
    
    static let identifier = "Section2CellIdentifier"
    
    var imageView: UIImageView!
    var info: [MenuInfo]!
    
    func configure(isGif: Bool) {
        imageView = UIImageView()
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false //important: or it will crash...
        if isGif {
            imageView.animationImages = [info[0].image, info[1].image]
            imageView.animationDuration = 1
            imageView.startAnimating()
        } else {
            imageView.image = info[0].image
        }
        NSLayoutConstraint.activate([imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }
    
}
