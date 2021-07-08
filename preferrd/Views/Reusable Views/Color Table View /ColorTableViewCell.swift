//
//  ColorTableViewCell.swift
//  preferrd
//
//  Created by Michelle Linus on 10/06/21.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
  // Required Payload
  var baseColor: Color!

  @IBOutlet var colorInfoButton: UIButton!
  @IBOutlet weak var colorBox: UIView!
  @IBOutlet weak var colorName: UILabel!
  @IBOutlet weak var colorHex: UILabel!
  @IBOutlet weak var colorBackground: UIStackView!
  @IBOutlet var relatedTagsCollectionView: UICollectionView!

  override func awakeFromNib() {
    super.awakeFromNib()
    setupTagCollectionView()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupStyling()
    setupBaseColor()
    // 3 JAM DEBUG CUMA GARA" GA RELOAD DATA. TOLONG AKU YA ALLAH
    relatedTagsCollectionView.reloadData()
  }

  func setupStyling() {
    colorBackground.applyShadow()
    colorBox.applyShadow()
  }

  func setupTagCollectionView() {
    (relatedTagsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?
      .estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    relatedTagsCollectionView.delegate = self
    relatedTagsCollectionView.dataSource = self
    let relatedTagCellNib = UINib(
      nibName: "\(RelatedTagsCollectionViewCell.self)",
      bundle: nil
    )
    relatedTagsCollectionView.register(
      relatedTagCellNib,
      forCellWithReuseIdentifier: "relatedTags"
    )
  }

  func setupBaseColor() {
    colorBox.backgroundColor  = UIColor(hex: baseColor.hex)
    colorName.text            = baseColor.name
    colorHex.text             = baseColor.hex
  }
}

extension ColorTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return baseColor.relatedTags.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "relatedTags",
        for: indexPath) as? RelatedTagsCollectionViewCell {
      cell.tagLabel.text = baseColor.relatedTags[indexPath.item].locale
      return cell
    }
    return UICollectionViewCell()
  }
}
