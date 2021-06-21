//
//  ColorTableViewCell.swift
//  preferrd
//
//  Created by Michelle Linus on 10/06/21.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
  // Required Payload
  var baseColor: Color! = Constants.colors[40]

  @IBOutlet var colorInfoButton: UIButton!
  @IBOutlet weak var colorBox: UIView!
  @IBOutlet weak var colorName: UILabel!
  @IBOutlet weak var colorHex: UILabel!
  @IBOutlet weak var colorBg: UIView!
  @IBOutlet var colorCollection: UICollectionView!

  override func awakeFromNib() {
    super.awakeFromNib()

    setupStyling()
    setupTagCollectionView()
    setupBaseColor()
  }

  func setupStyling() {
    colorBg.layer.cornerRadius = 12
    colorBox.layer.cornerRadius = 12
  }

  func setupTagCollectionView() {
    colorCollection.delegate = self
    colorCollection.dataSource = self
    //    colorCollection.register(tagNib, forCellWithReuseIdentifier: "colorCollectionCell")
    colorCollection.register(RelatedTagCollectionViewCell.self, forCellWithReuseIdentifier: "relatedTag")
  }

  func setupBaseColor() {
    colorBox.backgroundColor = UIColor(hex: baseColor.hex)
    colorName.text = baseColor.name
    colorHex.text = baseColor.hex
    colorCollection.reloadData()
  }
}

extension ColorTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    baseColor.relatedTags.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "relatedTag",
      for: indexPath
    ) as? RelatedTagCollectionViewCell {
//      cell.tagLabel.text = baseColor.relatedTags[indexPath.item].rawValue
      return cell
    }
    return UICollectionViewCell()
  }
}
