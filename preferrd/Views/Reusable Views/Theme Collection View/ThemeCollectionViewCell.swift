//
//  ThemeCollectionViewCell.swift
//  preferrd
//
//  Created by Antonio Mario on 10/06/21.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var themeContainer: UIView!
  @IBOutlet weak var themeLabel: UILabel!
  @IBOutlet weak var removeButton: UIButton!
  @IBOutlet weak var imageContainer: UIImageView!

  override func layoutSubviews() {
    super.layoutSubviews()
    themeContainer.layer.cornerRadius = 8
  }
}
