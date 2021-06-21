//
//  RelatedTagCollectionViewCell.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 20/06/21.
//

import UIKit

class RelatedTagCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var tagLabel: UILabel!
  @IBOutlet weak var tagLabelContainer: UIStackView!

  override func layoutSubviews() {
    super.layoutSubviews()
//    tagLabelContainer.applyShadow()
  }
}
