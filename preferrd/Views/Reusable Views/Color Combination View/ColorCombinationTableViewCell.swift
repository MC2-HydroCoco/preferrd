//
//  ColorCombinationTableViewCell.swift
//  preferrd
//
//  Created by Michelle Linus on 10/06/21.
//

import UIKit

class ColorCombinationTableViewCell: UITableViewCell {

    @IBOutlet weak var colorCombinationBakcground: UIView!
    @IBOutlet weak var colorBox1: UIView!
    @IBOutlet weak var colorBox2: UIView!
    @IBOutlet weak var colorBox3: UIView!
    @IBOutlet weak var colorBox4: UIView!
    @IBOutlet weak var colorBox5: UIView!
    @IBOutlet weak var colorCombinationName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorCombinationBakcground.layer.cornerRadius = 12
        colorBox1.layer.cornerRadius = 12
        colorBox2.layer.cornerRadius = 12
        colorBox3.layer.cornerRadius = 12
        colorBox4.layer.cornerRadius = 12
        colorBox5.layer.cornerRadius = 12
        
    

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func colorCombinationInformation(_ sender: UIButton) {
    }
}
