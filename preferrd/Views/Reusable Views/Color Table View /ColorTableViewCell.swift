//
//  ColorTableViewCell.swift
//  preferrd
//
//  Created by Michelle Linus on 10/06/21.
//

import UIKit

class ColorTableViewCell: UITableViewCell {

    @IBOutlet weak var colorBox: UIView!
    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var colorHex: UILabel!
    @IBOutlet weak var colorBackground: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        colorBackground.layer.cornerRadius = 12
        colorBox.layer.cornerRadius = 12
    }

    @IBAction func colorInformation(_ sender: UIButton) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
