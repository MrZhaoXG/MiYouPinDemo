//
//  Section2Info.swift
//  MiYouPin
//
//  Created by 赵锡光 on 2019/11/19.
//  Copyright © 2019 Mr.Zhao. All rights reserved.
//

import Foundation

class Section2Info {
    var infos = [[MenuInfo]]()
    init() {
        let url = URL(string: "baidu.com")!
        var info1 = [MenuInfo]()
        for i in 11...12 {
            let image1 = MenuInfo.initWithTitle("", url: url, image: UIImage(named: "未标题-\(i)")!)
            info1.append(image1 as! MenuInfo)
        }
        infos.append(info1)
        for i in 13...14 {
            let image = MenuInfo.initWithTitle("", url: url, image: UIImage(named: "未标题-\(i)")!)
            infos.append([image as! MenuInfo])
        }
    }
}
