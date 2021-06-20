//
//  ColorCombinationViewController.swift
//  preferrd
//
//  Created by Fandika Ikhsan on 14/06/21.
//

import UIKit

class ColorCombinationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    if tableView == relatedColorTableView {

      return 1
    } else {
      return 3
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    print("fandikaaaaaaaaaaaa\(tableView)")

    if tableView == relatedColorTableView {
      print("1")
      if let cell = tableView.dequeueReusableCell(
        withIdentifier: "relatedColorTableViewCell",
        for: indexPath
      ) as? ColorTableViewCell {
        cell.colorName.text = "fandika"
        return cell
      }
    } else {
      print("2")
      if let cell = tableView.dequeueReusableCell(
        withIdentifier: "colorCombinationTableViewCell",
        for: indexPath
      ) as? ColorCombinationTableViewCell {
        //        cell.colorCombinationName.text = "fandika"
        return cell
      }
    }
    return UITableViewCell()
  }

  @IBOutlet var relatedColorTableView: UITableView!
  @IBOutlet var combinationColorTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.

    let nibColorTableViewCell = UINib(nibName: "\(ColorTableViewCell.self)", bundle: nil)
    let nibColorCombinationTableViewCell = UINib(nibName: "\(ColorCombinationTableViewCell.self)", bundle: nil)

    // register nib to the cell
    relatedColorTableView.register(nibColorTableViewCell, forCellReuseIdentifier: "relatedColorTableViewCell")
    combinationColorTableView.register(
      nibColorCombinationTableViewCell,
      forCellReuseIdentifier: "colorCombinationTableViewCell"
    )

    relatedColorTableView.delegate = self
    relatedColorTableView.dataSource = self
    combinationColorTableView.delegate = self
    combinationColorTableView.dataSource = self

  }

}

//  extension ColorCombinationViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      print ("you tap")
//    }
//
//  }
//
//  extension ColorCombinationViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//      let cell = tableView.dequeueReusableCell(
//        withIdentifier: "colorCombinationTableViewCell",
//        for: indexPath
//      ) as! ColorCombinationTableViewCell
//
//      //custom data
//      cell.colorCombinationName.text = "fandika"
//
//      //return
//      return cell
//    }
//  }
