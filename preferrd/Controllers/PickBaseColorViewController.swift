//
//  PickBaseColorViewController.swift
//  preferrd
//
//  Created by Timothy Ananda on 21/06/21.
//

import UIKit

class PickBaseColorViewController: UIViewController {
  // Required Payload
  var themes = [ColorTheme]()

  @IBOutlet weak var themeCollectionView: UICollectionView!
  @IBOutlet weak var colorTableView: UITableView!

  var selectedColor: Color?
  var relatedColors = [Color]()

  override func viewDidLoad() {
    super.viewDidLoad()

//    navigationItem.rightBarButtonItem = UIBarButtonItem(
//      title: "Next",
//      style: .done,
//      target: self,
//      action: #selector(nextTapped)
//    )

    setupThemeCollectionView()
    setupColorTableView()
  }

  func setupThemeCollectionView() {
    let nibCell = UINib(nibName: "\(ThemeCollectionViewCell.self)", bundle: nil)

    themeCollectionView.register(
      nibCell,
      forCellWithReuseIdentifier: "themeCollectionViewCell"
    )

    themeCollectionView.delegate = self
    themeCollectionView.dataSource = self
  }

  func setupColorTableView() {
    let nibCell = UINib(nibName: "\(ColorTableViewCell.self)", bundle: nil)
    colorTableView.register(
      nibCell,
      forCellReuseIdentifier: "colorTableViewCell"
    )

    colorTableView.delegate = self
    colorTableView.dataSource = self
  }

  // MARK: - Prepare
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "pickColorCombination" {
      if let destination = segue.destination as? PickColorCombinationViewController,
         let color = sender as? Color {
        destination.baseColor = color
      }
    }
  }

//  @objc func nextTapped() {
//    performSegue(withIdentifier: "pickColorCombination", sender: self)
//  }
}

// MARK: - Related Tags Collection View
extension PickBaseColorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return themes.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "themeCollectionViewCell",
        for: indexPath) as? ThemeCollectionViewCell {
      cell.themeLabel.text = themes[indexPath.row].rawValue
      cell.imageContainer.isHidden = true
      cell.removeButton.isHidden = true
      return cell
    }
    return UICollectionViewCell()
  }
}

// MARK: - Related Colors Table View
extension PickBaseColorViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return relatedColors.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "colorTableViewCell") as? ColorTableViewCell {
      cell.baseColor        = relatedColors[indexPath.row]
      cell.selectionStyle   = .none
      return cell
    }
    return UITableViewCell()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    selectedColor = relatedColors[indexPath.row]
    print(relatedColors[indexPath.item])
    performSegue(withIdentifier: "pickColorCombination", sender: relatedColors[indexPath.item])
  }
}
