//
//  RelatedTagsCollectionViewCell.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 21/06/21.
//

import UIKit

class RelatedTagsCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var tagContainer: UIStackView!
  @IBOutlet weak var tagLabel: UILabel!

  override func layoutSubviews() {
    super.layoutSubviews()
    tagContainer.layer.cornerRadius = 6
  }

}
