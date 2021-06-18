//
//  PickThemeViewController.swift
//  preferrd
//
//  Created by Antonio Mario on 11/06/21.
//

import UIKit

class PickThemeViewController: UIViewController {

    @IBOutlet weak var themeCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var selectedTheme = [Int]() {
        didSet {
            themeCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: "\(ThemeCollectionViewCell.self)", bundle: nil)
        themeCollectionView.register(nibCell, forCellWithReuseIdentifier: "themeCollectionViewCell")
        
        themeCollectionView.delegate = self
        themeCollectionView.dataSource = self
        themeCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        themeCollectionView.allowsMultipleSelection = true

    }
}


extension PickThemeViewController: UICollectionViewDataSource, UICollectionViewDelegate,
                                   UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return selectedTheme.count
            
        } else {
            return ColorTheme.allCases.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "themeCollectionViewCell",
            for: indexPath) as? ThemeCollectionViewCell {
            
            
            if indexPath.section == 0 {
                cell.themeContainer.layer.cornerRadius = 12
                cell.imageOverlay.layer.backgroundColor = UIColor(hex: "#DEDEDE").cgColor
                cell.themeLabel.text = ColorTheme.allCases[selectedTheme[indexPath.row]].rawValue
                cell.imageContainer.isHidden = true
                cell.themeLabel.preferredMaxLayoutWidth = collectionView.frame.width - 32

            } else {
                let getColorTheme = ColorTheme.allCases[indexPath.row]
                cell.removeButton.isHidden = true
                cell.themeContainer.layer.cornerRadius = 12
                cell.themeLabel.text = getColorTheme.rawValue
                cell.imageContainer.image = getColorTheme.getImage()
                
            }
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            let item = ColorTheme.allCases[selectedTheme[indexPath.row]].rawValue
            let itemSize = item.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)
            ])
            return itemSize
        } else {
            let noOfCellsInRow = 2
            
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                    + flowLayout.sectionInset.right
                    + flowLayout.minimumInteritemSpacing
            let screenBounds = UIScreen.main.bounds
            let width = (screenBounds.width / CGFloat(noOfCellsInRow)) - totalSpace - (16*2)
            let height = (screenBounds.height / 10) - totalSpace
            return CGSize(width: width, height: height)
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        }else {
            
            let selectedCell:ThemeCollectionViewCell = themeCollectionView.cellForItem(at: indexPath)! as! ThemeCollectionViewCell
            selectedCell.layer.borderWidth = 4
            selectedCell.layer.borderColor = UIColor.black.cgColor
            print("jadi mencet?")
            
            selectedTheme.append(indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        }else {
            let cellToDeselect:ThemeCollectionViewCell = themeCollectionView.cellForItem(at: indexPath)! as! ThemeCollectionViewCell
            cellToDeselect.layer.borderColor = UIColor.clear.cgColor
            print("ga jadi deh")
        }
    }
}
