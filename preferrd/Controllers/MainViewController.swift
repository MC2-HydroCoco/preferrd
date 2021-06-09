//
//  ViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 28/05/21.
//

import UIKit

class MainViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var relatedColors = [UIColor]() {
    didSet {
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
    
    relatedColors = ColorCombination(baseColor: ColorMeaning.getRelatedColors(for: .fresh)[2].hex).triadic
  }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    relatedColors.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "relatedCell") as? RelatedColorCell {
      let color = relatedColors[indexPath.row]
      cell.colorPreview.backgroundColor = color
//      cell.colorName.text = color.name
      return cell
    }
    return UITableViewCell()
  }

}
