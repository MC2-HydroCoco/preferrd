//
//  PickThemeViewController.swift
//  preferrd
//
//  Created by Antonio Mario on 11/06/21.
//

import UIKit

class PickThemeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var themeCollectionView: UICollectionView!
    //    @IBOutlet weak var themeVerticalStack: UIStackView!
    
    var selectedTheme = [ColorTheme]() {
        didSet{tagCollectionView.reloadData()}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == tagCollectionView) {
            
        } else {
            return ColorTheme.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
    
}
