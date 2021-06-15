//
//  PickThemeViewController.swift
//  preferrd
//
//  Created by Antonio Mario on 11/06/21.
//

import UIKit

class PickThemeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var themeImages:[String] = [
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                ""
    ]
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var themeCollectionView: UICollectionView!
    //    @IBOutlet weak var themeVerticalStack: UIStackView!

    var selectedTheme = [ColorTheme]() {
        didSet{tagCollectionView.reloadData()}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: "ThemeCollectionViewCell", bundle: nil)
        themeCollectionView.register(nibCell, forCellWithReuseIdentifier: "themeCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == tagCollectionView) {
            return selectedTheme.count
        } else {
            return ColorTheme.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "themeCollectionViewCell", for: indexPath) as? ThemeCollectionViewCell {
            if (collectionView == tagCollectionView) {
                cell.removeButton
                cell.themeContainer
                cell.themeLabel
                cell.imageContainer.isHidden = true
                
            } else {
                cell.removeButton.isHidden = true
                cell.themeContainer
                cell.themeLabel
                cell.imageContainer.image = UIImage(named: themeImages[indexPath.row])
        }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("abcde")
    }
    
}
