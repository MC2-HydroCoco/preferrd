//
//  ViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 28/05/21.
//

import UIKit

class MainViewController: UIViewController {

  var userSelection = [ColorMeanings]()
  var relatedColors = [String: [Color]]()
  var relatedTags   = [String: [String]]()

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
    print("All Colors:", Color.getAllColors())
    print("All Color Meanings:", ColorMeanings.getAllColorMeanings())
  }
}
