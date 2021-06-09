//
//  ViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 28/05/21.
//

import UIKit

class MainViewController: UIViewController {

  var userSelection = [ColorMeaning]()
  var relatedColors = [String: [Color]]()
  var relatedTags   = [String: [String]]()
  @IBOutlet weak var colorView: UIView!
  @IBOutlet weak var hexCode: UILabel!
  @IBOutlet weak var colorDesc: UILabel!

  @IBOutlet var colorPalette: [UIView]!

  override func viewDidLoad() {
    super.viewDidLoad()
    userSelection = [.elegant, .relaxing]

    userSelection.forEach { meaning in
      relatedColors[meaning.rawValue] = meaning.getRelatedColors()
      meaning.getRelatedColors().forEach { color in
        relatedTags[color.rawValue] = color.getTags()
      }
    }

    print("User Selection:", userSelection)
    print("Related Colors:", relatedColors)
    print("Related Tags:", relatedTags)

    colorView.backgroundColor = Color.blue.getUIColor()
    hexCode.text = Color.blue.hex
    colorDesc.text = Color.blue.description

    let myColorSet = ColorCombination(baseColor: .orange).splitComplementary
    myColorSet.enumerated().forEach { (index, color) in
      colorPalette[index].backgroundColor = color
    }
  }
}
