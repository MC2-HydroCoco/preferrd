//
//  RelatedColorsViewController.swift
//  preferrd
//
//  Created by Fandika Ikhsan on 17/06/21.
//

import UIKit

// CUSTOM HEX COLOR
var colorBlack = UIColor(hex: "#171717")
var defaultTableCellColor = UIColor(hex: "#FFFFFF")

// MAIN

class RelatedColorsViewController: UIViewController {
  // DATA
  // data dari color models
  var selectedTheme: [ColorTheme] = [.relaxing, .nature]
  // data dari previous page
  var relatedColors: [Color] = []

  @IBOutlet var tagsCollectionView: UICollectionView!
  @IBOutlet var relatedColorTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    // closure?
    selectedTheme.forEach({ theme in
      relatedColors.append(contentsOf: ColorTheme.getRelatedColors(for: theme))
    })

    // NIB

    // declare nibVar for each of xib
    let nibRelatedColorTableView = UINib(nibName: "\(ColorTableViewCell.self)", bundle: nil)
    let nibTagsCollectionView = UINib(nibName: "\(TagsCollectionViewCell.self)", bundle: nil)

    // register xib to outlet
    tagsCollectionView.register(nibTagsCollectionView, forCellWithReuseIdentifier: "tagsCollectionViewCell")
    relatedColorTableView.register(nibRelatedColorTableView, forCellReuseIdentifier: "relatedColorTableViewCell")

    // delegate and datasource
    tagsCollectionView.delegate = self
    relatedColorTableView.delegate = self
    tagsCollectionView.dataSource = self
    relatedColorTableView.dataSource = self

    self.relatedColorTableView.separatorColor = UIColor.clear

  }

}

// ACTION WHEN CLICKED

extension RelatedColorsViewController: UICollectionViewDelegate, UITableViewDelegate {

  // WHEN SELECT
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // CUSTOM WHEN CLICKED

    if let cell = tableView.cellForRow(at: indexPath) as? ColorTableViewCell {

      cell.colorBg.backgroundColor = colorBlack
      cell.colorName.textColor = .white
      cell.colorHex.textColor = .white
      cell.colorInfoButton.tintColor = .white
      print("you tapped tablecell \(indexPath)")
        
        
        
    }
  }

  //    // WHEN DESELECET
  //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
  //
  //        let cell = tableView.cellForRow(at: indexPath) as! ColorTableViewCell
  //        cell.colorBackground.backgroundColor = defaultTableCellColor
  //
  //
  //    }
  //
  //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  //        print("you tapped collectioncell")
  //
  //    }
}

// CELL WHEN RENDERED

extension RelatedColorsViewController: UICollectionViewDataSource, UITableViewDataSource {

  // Banyaknya yang digenerate
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return selectedTheme.count
    
    
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return relatedColors.count
  }

  // dequeue
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(
      withIdentifier: "relatedColorTableViewCell",
      for: indexPath
    ) as? ColorTableViewCell {

      // custom data
      cell.colorName.text = relatedColors[indexPath.row].name
      cell.colorHex.text = relatedColors[indexPath.row].hex
      cell.colorBox.backgroundColor = UIColor(hex: relatedColors[indexPath.row].hex)
    

      cell.selectionStyle = .none

      // return
      return cell
    }
    return UITableViewCell()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "tagsCollectionViewCell",
      for: indexPath
    ) as? TagsCollectionViewCell {

      // custom data
      cell.tagLabel.text = selectedTheme[indexPath.row].rawValue

      // return
      return cell
    }
    return UICollectionViewCell()
  }

}

// Number of Section Function

//    // number of section
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
//    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "seeColorColorCombinations" {
//            if let VCTujuan = segue.destination as? ColorCombinationViewController,
//               let colorYgMaudiPas = sender as? Color {
//               VCTujuan.baseColor = colorYgMaudiPas
//            }
//        }
//    }
