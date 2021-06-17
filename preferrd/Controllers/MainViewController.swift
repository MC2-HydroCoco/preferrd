//
//  ViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 28/05/21.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    @IBOutlet weak var userPaletteTable: UITableView!
    
    var palettes: [Palette] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let nibCell = UINib(nibName: "PaletteTableViewCell", bundle: nil)
        userPaletteTable.register(nibCell, forCellReuseIdentifier: "userPaletteTableViewCell")
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        palettes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
}
