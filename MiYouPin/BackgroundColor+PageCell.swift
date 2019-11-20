//
//  BackgroundColor+PageCell.swift
//  MiYouPin
//
//  Created by 赵锡光 on 2019/11/14.
//  Copyright © 2019 Mr.Zhao. All rights reserved.
//

import UIKit

protocol ColorChangedDelegate: class {
    func colorChangeTo(_ color: UIColor)
}

class BackgroundColor_PageCell: UICollectionViewCell {
    
    var colorView: UIView!
    var colorChangedDelegate: ColorChangedDelegate?
    var scrollView: UIScrollView!
    var pageController: UIPageControl!
    var imageViews: [UIImageView]! = []
    var nowColor: UIColor? = .clear
    var nextColor: UIColor? = .clear
    var colors: [Int: UIColor] = [:] {
        didSet {
            if colors.count == imageViews.count {
                DispatchQueue.main.async {
                    self.colorView.backgroundColor = self.colors[0]
                    self.colorChangedDelegate?.colorChangeTo(self.colors[0]!)
                }
            }
        }
    }
    let id = "autoNext"
    var lastOffsetX: CGFloat = 0
    var shouldAutoStop = false {
        didSet {
            if shouldAutoStop {
                delayedTask.cancel(id)
            } else {
                delayedTask.resume(id)
            }
        }
    }
    let delayedTask = DelayedTask()
    var sizeOfView = CGSize.zero
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        test()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func test() {
        configureColorView()
        configureWhiteColor()
        configureScollView()
        configureImageView()
        calculateColors()
        automaticalScroll(interval: 3)
        configurePageController()
    }
    
    func configureColorView() {
        colorView = UIView()
        self.contentView.addSubview(colorView)
        self.bringSubviewToFront(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     colorView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     colorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }
    
    func configureWhiteColor() {
        print("white color")
        var frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        frame.origin.y += self.frame.height * 0.7
        let whileView = UIView(frame: frame)
        colorView.addSubview(whileView)
        colorView.clipsToBounds = true
        whileView.layer.cornerRadius = 15
        whileView.layer.masksToBounds = true
        whileView.backgroundColor = .white
    }

    
    func configureScollView() {
        let nums: CGFloat = 6
        let width = self.frame.width * nums
        let height = self.frame.height
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 200))
        self.contentView.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: width, height: height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
    }
    
    func configureImageView() {
        let width = self.frame.width
        for i in 0...5 {
            let startX = width * CGFloat(i) + width / 15
            let _width = width / 15 * 13
            let frame = CGRect(x: startX, y: 0, width: _width, height: self.frame.height)
            let imageView = UIImageView(frame: frame)
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: "testImage\(i)")
            imageView.layer.cornerRadius = 10
            imageView.layer.masksToBounds = true
            imageViews.append(imageView)
            scrollView.addSubview(imageView)
        }
    }
    
    
    func configurePageController() {
        pageController = UIPageControl()
        self.addSubview(pageController)
        pageController.numberOfPages = imageViews.count
        pageController.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([pageController.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     pageController.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)])
        contentView.bringSubviewToFront(pageController)
    }
    
    func calculateColors() {
        for (index,imageView) in self.imageViews.enumerated() {
            DispatchQueue.global().sync {
                let color = imageView.image?.mostColor()
                if color != nil {
                    self.colors[index] = color!
                }
            }
        }
    }
    
    func automaticalScroll(interval: Int) {
        delayedTask.addTask(withDelay: Double(interval), id: id) {
            var width = self.scrollView.frame.width + self.scrollView.contentOffset.x
            let remain = Int(width) % Int(self.scrollView.frame.width)
            width = (remain == 0 ? width : (width - CGFloat(remain)))
            let needReturn = Int(width) / Int(self.scrollView.contentSize.width) == 1
            let point = CGPoint(x: needReturn ? 0 : width, y: 0)
            self.scrollView.setContentOffset(point, animated: true)
            self.automaticalScroll(interval: interval)
        }
    }
}

extension BackgroundColor_PageCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isNext: Bool = scrollView.contentOffset.x > lastOffsetX
        let _nowIndex = scrollView.contentOffset.x / self.frame.width
        let nowIndex = Int(_nowIndex)
        var ratio = CGFloat(Int(scrollView.contentOffset.x) % Int(self.frame.width)) / self.frame.width
        ratio = isNext ? ratio : (1 - ratio)
        nowColor = colors[nowIndex]
        nextColor = colors[nowIndex + 1]
        if !isNext {
            (nowColor, nextColor) = (nextColor, nowColor)
        }
        guard let nextColor = nextColor?.cgColor, let nowColor = nowColor?.cgColor else { return }
        guard let componnets1 = nowColor.components, let components2 = nextColor.components else { return }
        guard ratio != 0 else { return }
        let red = componnets1[0] + ((components2[0] - componnets1[0]) * ratio)
        let green = componnets1[1] + ((components2[1] - componnets1[1]) * ratio)
        let blue = componnets1[2] + ((components2[2] - componnets1[2]) * ratio)
        let targetColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        colorChangedDelegate?.colorChangeTo(targetColor)
        colorView.backgroundColor = targetColor
        lastOffsetX = scrollView.contentOffset.x
        pageController.currentPage = Int(_nowIndex.rounded())
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        shouldAutoStop = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        shouldAutoStop = false
    }
}
