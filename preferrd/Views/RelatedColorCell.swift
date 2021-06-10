//
//  relatedColorCell.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 10/06/21.
//

import UIKit

class RelatedColorCell: UITableViewCell {

  @IBOutlet weak var colorPreview: UIView!
  @IBOutlet weak var colorName: UILabel!
  @IBOutlet weak var relatedTags: UILabel!
  @IBOutlet weak var hexCode: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
