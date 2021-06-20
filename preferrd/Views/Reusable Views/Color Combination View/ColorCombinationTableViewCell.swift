//
//  ColorCombinationTableViewCell.swift
//  preferrd
//
//  Created by Michelle Linus on 10/06/21.
//

import UIKit

class ColorCombinationTableViewCell: UITableViewCell {
  // Required Payload
  var baseColor: UIColor!
  var colorCombination: ColorCombination!
  weak var delegate: UIViewController!

  // Cell Properties
  var popup: UIView?
  @IBOutlet var colorSet: [UIView]!
  @IBOutlet weak var combinationNameLabel: UILabel!
  @IBOutlet weak var combinationContainer: UIStackView!

  override func layoutSubviews() {
    super.layoutSubviews()

    // Name combination
    combinationNameLabel.text = colorCombination.rawValue

    // Display combination colors
    if let colorCombination = colorCombination {
      let combination = colorCombination.getCombination(from: baseColor)
      combination.enumerated().forEach { (index, color) in
        colorSet[index].backgroundColor = color
      }
    }

    // Apply styling
    combinationContainer.applyShadow()
    colorSet.forEach { $0.applyShadow() }
  }

  @IBAction func showCombinationInfo(_ sender: Any) {
    if let popup = popup {
      UIView.animate(withDuration: 0.35) {
        popup.layer.opacity = 0
      } completion: { _ in
        popup.removeFromSuperview()
        self.popup = nil
      }
    } else {
      popup = delegate.popup(
        title: colorCombination.rawValue,
        detail: colorCombination.description
      ) {
        self.popup = nil
      }
    }
  }
}
