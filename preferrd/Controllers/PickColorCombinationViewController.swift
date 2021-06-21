//
//  PickColorCombinationViewController.swift
//  preferrd
//
//  Created by Michelle Linus on 15/06/21.
//

import UIKit

class PickColorCombinationViewController: UIViewController {

  // Required Payload
  var baseColor: Color!

  // Base Color View
  @IBOutlet weak var baseColorBackground: UIStackView!
  @IBOutlet weak var baseColorView: UIView!
  @IBOutlet weak var baseColorName: UILabel!
  @IBOutlet weak var baseColorHex: UILabel!
  @IBOutlet weak var baseColorRelatedTags: UICollectionView!

  // Color Combination List
  @IBOutlet weak var colorCombinationTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupBaseColorView()
    setupColorCombinationList()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "seePalettePreview" {
      if let palettePreview = segue.destination as? PalettePreviewViewController,
         let combination = sender as? ColorCombination {
        let color = UIColor(hex: baseColor.hex)
        palettePreview.selectedCombination = combination.getCombination(from: color)
      }
    }
  }

  private func setupBaseColorView() {
    [baseColorBackground, baseColorView].forEach { $0.applyShadow() }
    baseColorView.backgroundColor = UIColor(hex: baseColor.hex)
    baseColorName.text            = baseColor.name
    baseColorHex.text             = baseColor.hex

    // Setup Related Tags Collection View
    baseColorRelatedTags.delegate   = self
    baseColorRelatedTags.dataSource = self
  }

  private func setupColorCombinationList() {
    colorCombinationTableView.delegate    = self
    colorCombinationTableView.dataSource  = self

    // Register Cell
    let nib = UINib(nibName: "ColorCombinationTableViewCell", bundle: nil)
    colorCombinationTableView.register(nib, forCellReuseIdentifier: "colorCombinationCell")
  }

  @IBAction func showBaseColorDetail(_ sender: Any) {
    print("Detail:", baseColor.colorDescription)
  }
}

// MARK: - Related Tags Collection View
extension PickColorCombinationViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    baseColor.relatedTags.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "relatedTag",
      for: indexPath
    ) as? ColorCombinationTagCollectionViewCell {
      cell.tagLabel.text = baseColor.relatedTags[indexPath.item].rawValue
      return cell
    }
    return UICollectionViewCell()
  }
}

// MARK: - Color Combiantion Table View
extension PickColorCombinationViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    ColorCombination.allCases.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(
        withIdentifier: "colorCombinationCell"
    ) as? ColorCombinationTableViewCell {

      cell.selectionStyle    = .none
      cell.baseColor         = UIColor(hex: baseColor.hex)
      cell.colorCombination  = ColorCombination.allCases[indexPath.row]
      cell.delegate          = self

      return cell
    }
    return UITableViewCell()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(
      withIdentifier: "seePalettePreview",
      sender: ColorCombination.allCases[indexPath.row]
    )
  }
}
