//
//  ViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 28/05/21.
//

import UIKit

class MainViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  var selectedEmotions =  [ColorTheme]()
  var colorsRelatedToTheme = [[Color]]()
  var result = [UIColor]() {
    didSet { tableView.reloadData() }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self

    selectedEmotions = [.elegant, .masculine, .adventurous]
    selectedEmotions.forEach { theme in
      colorsRelatedToTheme.append(ColorTheme.getRelatedColors(for: theme))
    }
  }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return selectedEmotions[section].rawValue
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    colorsRelatedToTheme.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    colorsRelatedToTheme[section].count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "relatedCell") as? RelatedColorCell {
      let color = colorsRelatedToTheme[indexPath.section][indexPath.row]
      cell.colorPreview.backgroundColor = UIColor(hex: color.hex)
      cell.colorName.text = color.name
      cell.hexCode.text = color.hex
      cell.relatedTags.text = color.relatedTags.reduce("", { $0 + "\($1.rawValue), "})
      return cell
    }

    return UITableViewCell()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "seeCombination", sender: colorsRelatedToTheme[indexPath.section][indexPath.row])
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "seeCombination" {
      if let combinationVC = segue.destination as? ColorCombinationsViewController,
         let color = sender as? Color {
        combinationVC.baseColor = color
      }
    }
  }

}

// MARK: - Color Combination
class ColorCombinationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var colorPreview: UIView!
  @IBOutlet weak var colorName: UILabel!
  @IBOutlet weak var colorHex: UILabel!
  @IBOutlet weak var tableView: UITableView!

  var baseColor: Color!
  var colorCombinations: [ColorCombination] = [
    .analogous,
    .complementary,
    .monochromatic,
    .splitComplementary,
    .triadic
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self

    colorPreview.backgroundColor = UIColor(hex: baseColor.hex)
    colorName.text = baseColor.name
    colorHex.text = baseColor.hex
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "seeSet" {
      if let colorSetVC = segue.destination as? ColorSetViewController,
         let baseColors = sender as? [UIColor] {
        colorSetVC.colorSet = baseColors
      }
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    colorCombinations.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "combinationCell") as? ColorCombinationCell {
      let combination = colorCombinations[indexPath.row]
      cell.colors = combination.getCombination(from: UIColor(hex: baseColor.hex))
      cell.combinationName.text = combination.rawValue
      return cell
    }
    return UITableViewCell()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "seeSet",
                 sender: colorCombinations[indexPath.row].getCombination(from: UIColor(hex: baseColor.hex)))
  }

}

class ColorCombinationCell: UITableViewCell {
  @IBOutlet weak var combinationName: UILabel!
  @IBOutlet var combinationColors: [UIView]!

  var colors: [UIColor]!

  override func layoutSubviews() {
    combinationColors.enumerated().forEach { $1.backgroundColor = colors[$0] }
  }
}

// MARK: - Color Set
class ColorSetViewController: UIViewController {
  @IBOutlet var colorSetPreview: [UIView]!
  var colorSet = [UIColor]()

  override func viewDidLoad() {
    super.viewDidLoad()
    ColorSet.from(colorSet).enumerated().forEach { (index, color) in
      colorSetPreview[index].backgroundColor = color
    }
  }
}
