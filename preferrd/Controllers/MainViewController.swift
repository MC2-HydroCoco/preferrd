//
//  ViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 28/05/21.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    @IBOutlet weak var paletteTableView: UITableView!
    
    var palettes: [Palette] = []
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
        
//        paletteManager.add(name: "Sample Palette", backgroundHex: "#FFFFFF", headlineHex: "#212121", bodyHex: "#303030", buttonBgHex: "#121212", buttonTextHex: "#FFFFFF")
        palettes = paletteManager.fetch()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return palettes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paletteTableViewCell") as! PaletteTableViewCell
        
        let palette = palettes[indexPath.row]
        print(palette)
        
        cell.nameLabel.text = palette.name
        cell.backgroundColorView.backgroundColor = UIColor(hex: palette.backgroundHex!)
        cell.headlineColorView.backgroundColor = UIColor(hex: palette.headlineHex!)
        cell.bodyColorView.backgroundColor = UIColor(hex: palette.bodyHex!)
        cell.buttonBgView.backgroundColor = UIColor(hex: palette.buttonBgHex!)
        cell.buttonTextView.backgroundColor = UIColor(hex: palette.buttonTextHex!)
        
        return cell
    }
    
}
