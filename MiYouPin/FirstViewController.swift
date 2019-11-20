//
//  FirstViewController.swift
//  MiYouPin
//
//  Created by 赵锡光 on 2019/11/13.
//  Copyright © 2019 Mr.Zhao. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuInfo()
        configureSearchBar()
        configureCollectionView()
    }
    
    //MARK: add UIController

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let menuIdentifier = "menuIdentifier"
    private var menuInfos: [MenuInfo] = []
    private var section2Infos = [[MenuInfo]]()

    
    func configureSearchBar() {
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuIdentifier)
        collectionView.register(Section2Cell.self, forCellWithReuseIdentifier: Section2Cell.identifier)
        collectionView.register(BackgroundColor_PageCell.self, forCellWithReuseIdentifier: "backgroundColorCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureMenuInfo() {
        let _menuInfos = MenuInfos()
        self.menuInfos = _menuInfos.infos as! [MenuInfo]
        let section2Info = Section2Infos()
        self.section2Infos = section2Info.infos as! [[MenuInfo]]
    }
}

extension FirstViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return menuInfos.count
        case 2:
            return section2Infos.count
        default:
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "backgroundColorCell", for: indexPath) as? BackgroundColor_PageCell {
                cell.colorChangedDelegate = self
                return cell
            }
        } else if indexPath.section == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuIdentifier, for: indexPath) as? MenuCell {
                cell.info = menuInfos[indexPath.item]
                cell.configure()
                return cell
            }
        } else if indexPath.section == 2 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Section2Cell.identifier, for: indexPath) as? Section2Cell {
                cell.info = section2Infos[indexPath.item]
                cell.configure(isGif: indexPath.item == 0)
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    
}

extension FirstViewController: UICollectionViewDelegate {
    
}

extension FirstViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize.zero
        if indexPath.section == 0 {
            size = CGSize(width: collectionView.frame.width, height: 200)
        } else if indexPath.section == 1 {
            let width = (view.frame.width - 50) / 6
            size = CGSize(width: width, height: width)
        } else if indexPath.section == 2 {
            let width = collectionView.frame.width
            let height: CGFloat = 200
            if indexPath.item == 0 {
                size = CGSize(width: width / 3, height: height)
            } else {
                size = CGSize(width: width / 6, height: height)
            }
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 || section == 2 {
            let inset: CGFloat = 25
            return .init(top: inset, left: inset, bottom: inset, right: inset)
        }
        return .zero
    }
}

extension FirstViewController: ColorChangedDelegate {
    func colorChangeTo(_ color: UIColor) {
        self.colorView.backgroundColor = color
    }
}

