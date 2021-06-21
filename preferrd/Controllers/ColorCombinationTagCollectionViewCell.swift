//
//  ColorCombinationTagCollectionViewCell.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 22/06/21.
//

import UIKit

class ColorCombinationTagCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var tagLabel: UILabel!
  @IBOutlet weak var tagLabelContainer: UIStackView!

  override func layoutSubviews() {
    super.layoutSubviews()
    tagLabelContainer.layer.cornerRadius = 8
  }
}
