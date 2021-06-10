//
//  ViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 28/05/21.
//

import UIKit

class MainViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  var selectedEmotions =  [ColorMeaning]()
  var relatedColors = [UIColor]() {
    didSet {
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
//    relatedColors = ColorCombination(baseColor: ColorMeaning.getRelatedColors(for: .fresh)[2].hex).triadic

    selectedEmotions = [.elegant, .masculine]
  }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    Constants.colors.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "relatedCell") as? RelatedColorCell {
      let color = Constants.colors[indexPath.row]
      cell.colorPreview.backgroundColor = UIColor(hex: color.hex)
      cell.colorName.text = color.name
      cell.hexCode.text = color.hex
      var relatedTags = ""
      color.relatedTags.forEach { relatedTags += $0.rawValue }
      cell.relatedTags.text = relatedTags
      return cell
    }
    return UITableViewCell()
  }

}
