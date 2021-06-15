//
//  ViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 28/05/21.
//

import UIKit

class MainViewController: UIViewController {

  @IBOutlet weak var userPaletteTable: UITableView!
  @IBOutlet weak var userPaletteTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    let nibCell = UINib(nibName: "PaletteTableViewCell", bundle: nil)
    userPaletteTable.register(nibCell, forCellReuseIdentifier: "userPaletteTableViewCell")
  }
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//  }

//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    if let cell = tableView.dequeueReusableCell(withIdentifier: "userPaletteTableViewCell") as? PaletteTableViewCell {
//      cell.colorPalette2
//      cell.colorPalette3
//      cell.colorPalette4
//      cell.colorPalette5
//      cell.colorPallete
//      cell.labelPalette
//    }
//  }
}

extension MainViewController: UITableViewDataSource, UITabBarDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    UITableViewCell()
  }

}
