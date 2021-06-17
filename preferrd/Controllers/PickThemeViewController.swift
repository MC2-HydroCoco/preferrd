//
//  PickThemeViewController.swift
//  preferrd
//
//  Created by Antonio Mario on 11/06/21.
//

import UIKit

class PickThemeViewController: UIViewController {
  @IBOutlet weak var tagCollectionView: UICollectionView!
  @IBOutlet weak var themeCollectionView: UICollectionView!

  var selectedTheme = [ColorTheme]() {
    didSet {
      tagCollectionView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let nibCell = UINib(nibName: "\(ThemeCollectionViewCell.self)", bundle: nil)
    themeCollectionView.register(nibCell, forCellWithReuseIdentifier: "themeCollectionViewCell")
//    let nibCellTag = UINib(nibName: "\(ThemeCollectionViewCell.self)", bundle: nil)
    tagCollectionView.register(nibCell, forCellWithReuseIdentifier: "tagCollectionViewCell")
    
    themeCollectionView.delegate = self
    themeCollectionView.dataSource = self
    themeCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    
    tagCollectionView.delegate = self
    tagCollectionView.dataSource = self
  }

}

extension PickThemeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            return selectedTheme.count
            
        } else {
            return ColorTheme.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "themeCollectionViewCell",
            for: indexPath) as? ThemeCollectionViewCell {
            
            let getColorTheme = ColorTheme.allCases[indexPath.row]
            
            if collectionView == tagCollectionView {
                cell.themeContainer.layer.cornerRadius = 12
                cell.themeLabel.text = getColorTheme.rawValue
                cell.imageContainer.isHidden = true
                
            } else {
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
        let noOfCellsInRow = 6

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let screenBounds = UIScreen.main.bounds
        let width = (screenBounds.width / 2.36) - totalSpace / CGFloat(noOfCellsInRow)
        let height = (screenBounds.height / 9.431) - totalSpace / CGFloat(noOfCellsInRow)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tagCollectionView {
            
        }else {
            let selectedCell:UICollectionViewCell = themeCollectionView.cellForItem(at: indexPath)!
            selectedCell.contentView.backgroundColor = UIColor(red: 102/256, green: 255/256, blue: 255/256, alpha: 0.66)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == tagCollectionView {
            
        }else {
            let cellToDeselect:UICollectionViewCell = themeCollectionView.cellForItem(at: indexPath)!
            cellToDeselect.contentView.backgroundColor = UIColor.clear
        }
    }
}
