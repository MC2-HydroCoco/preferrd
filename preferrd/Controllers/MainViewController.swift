//
//  ViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 28/05/21.
// swiftlint:disable force_cast

import UIKit
import CoreData

class MainViewController: UIViewController {
  @IBOutlet weak var paletteTableView: UITableView!

  var palettes: [Palette] = [] {
    didSet {
      paletteTableView.reloadData()
    }
  }
  let paletteManager = PaletteManager()

  override func viewDidLoad() {
    super.viewDidLoad()

    paletteTableView.delegate = self
    paletteTableView.dataSource = self

    let nibCell = UINib(nibName: "\(PaletteTableViewCell.self)", bundle: nil)
    paletteTableView.register(nibCell, forCellReuseIdentifier: "paletteTableViewCell")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    palettes = paletteManager.fetch()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "editPalette" {
      if let destination = segue.destination as? FinalPalettePreviewViewController,
         let payload = sender as? Palette {
        destination.paletteToUpdate = payload
        destination.palette = [
          UIColor(hex: payload.backgroundHex!),
          UIColor(hex: payload.headlineHex!),
          UIColor(hex: payload.bodyHex!),
          UIColor(hex: payload.buttonBgHex!),
          UIColor(hex: payload.buttonTextHex!)
        ]
      }
    }
  }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return palettes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "paletteTableViewCell") as! PaletteTableViewCell

    let palette = palettes[indexPath.row]

    cell.nameLabel.text = palette.name
    cell.nameLabel.textColor = Constants.AppColors.dark
    cell.nameLabel.superview?.backgroundColor = Constants.AppColors.light
    cell.backgroundColorView.backgroundColor = UIColor(hex: palette.backgroundHex!)
    cell.headlineColorView.backgroundColor = UIColor(hex: palette.headlineHex!)
    cell.bodyColorView.backgroundColor = UIColor(hex: palette.bodyHex!)
    cell.buttonBgView.backgroundColor = UIColor(hex: palette.buttonBgHex!)
    cell.buttonTextView.backgroundColor = UIColor(hex: palette.buttonTextHex!)

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "editPalette", sender: palettes[indexPath.row])
  }
}
