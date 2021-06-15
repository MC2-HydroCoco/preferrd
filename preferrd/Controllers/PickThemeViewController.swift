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
  //    @IBOutlet weak var themeVerticalStack: UIStackView!

  var selectedTheme = [ColorTheme]() {
    didSet {
      tagCollectionView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let nibCell = UINib(nibName: "\(ThemeCollectionViewCell.self)", bundle: nil)
    themeCollectionView.register(nibCell, forCellWithReuseIdentifier: "themeCollectionViewCell")
    themeCollectionView.delegate = self
    themeCollectionView.dataSource = self
    tagCollectionView.delegate = self
    tagCollectionView.dataSource = self
  }

}

extension PickThemeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == tagCollectionView {

    } else {

    }
  }
}
