//
//  ThemeView.swift
//  preferrd
//
//  Created by Timothy Ananda on 21/06/21.
//

import UIKit

class ThemeView: UIView {

  @IBOutlet weak var themeLabel: UILabel!
  @IBOutlet weak var themeImageView: UIImageView!

  var isSelected: Bool = false

  func toggleSelect() {
    isSelected.toggle()

    if isSelected {
      themeImageView.alpha = 0.4
    } else {
      themeImageView.alpha = 1
    }
  }
}
