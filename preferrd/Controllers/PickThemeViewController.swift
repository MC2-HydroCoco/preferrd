//
//  PickThemeViewController.swift
//  preferrd
//
//  Created by Antonio Mario on 11/06/21.
//
// swiftlint:disable force_cast

import UIKit

class PickThemeViewController: UIViewController {
    
    @IBOutlet weak var themeCollectionView: UICollectionView!
    
    @IBOutlet var themeSet: [UIView]!
    
    var selectedTheme = [Int]() {
        didSet {
            themeCollectionView.reloadData()
        }
    }
    
    var arrayOfColorTheme = [ColorTheme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: "\(ThemeCollectionViewCell.self)", bundle: nil)
        themeCollectionView.register(nibCell, forCellWithReuseIdentifier: "themeCollectionViewCell")
        
        themeCollectionView.delegate = self
        themeCollectionView.dataSource = self
        themeCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        themeCollectionView.allowsMultipleSelection = true
        
        setupThemeSet()
    }
    
    func setupThemeSet() {
        for themeView in themeSet {
            themeView.layer.cornerRadius = 12
        }
    }
}

extension PickThemeViewController: UICollectionViewDataSource, UICollectionViewDelegate,
                                   UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTheme.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "themeCollectionViewCell",
            for: indexPath) as? ThemeCollectionViewCell {
            
            cell.themeContainer.layer.cornerRadius = 12
            cell.imageOverlay.layer.backgroundColor = UIColor(hex: "#DEDEDE").cgColor
            cell.themeLabel.text = ColorTheme.allCases[selectedTheme[indexPath.row]].rawValue
            cell.imageContainer.isHidden = true
            cell.imageOverlay.layer.cornerRadius = 12
            cell.themeLabel.preferredMaxLayoutWidth = collectionView.frame.width - 32
            cell.removeButton.isHidden = false
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            cell.addGestureRecognizer(tapRecognizer)
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let item = ColorTheme.allCases[selectedTheme[indexPath.row]].rawValue
        let itemSize = item.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36)
        ])
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTheme.remove(at: indexPath.row)
        print("kons")
    }
    
    @objc func handleTap (_ sender: UITapGestureRecognizer) {
        //        let location = sender.location(in: themeCollectionView)
        //        if let indexPath = themeCollectionView.indexPathForItem(at: location) {
        //            guard let cell = themeCollectionView.cellForItem(at: indexPath) as? ThemeCollectionViewCell
        //            else {
        //                return
        //            }
        //            if cell.removeButton.frame.contains(location) {
        //                selectedTheme.remove(at: indexPath.row)
        //            }
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}
