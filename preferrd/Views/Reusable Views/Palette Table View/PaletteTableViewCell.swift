//
//  PaletteTableViewCell.swift
//  preferrd
//
//  Created by Fandika Ikhsan on 10/06/21.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {

  @IBOutlet weak var paletteBackgroundView: UIView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var backgroundColorView: UIView!
  @IBOutlet var headlineColorView: UIView!
  @IBOutlet var bodyColorView: UIView!
  @IBOutlet var buttonBgView: UIView!
  @IBOutlet var buttonTextView: UIView!

  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
    paletteBackgroundView.applyShadow()

    [
      backgroundColorView,
      headlineColorView,
      bodyColorView,
      buttonBgView,
      buttonTextView
    ].style(for: .palette)

    nameLabel.textColor = Constants.AppColors.dark
    paletteBackgroundView.backgroundColor = Constants.AppColors.light
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
}

extension Array where Element: UIView {
  enum StylingType {
    case palette
  }

  func style(for type: StylingType) {
    switch type {
    case .palette:
      self.forEach { view in
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.2
      }
    }
  }
}
