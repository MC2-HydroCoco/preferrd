//
//  PaletteTableViewCell.swift
//  preferrd
//
//  Created by Fandika Ikhsan on 10/06/21.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {

    @IBOutlet var labelPalette: UILabel!
    @IBOutlet var colorPallete: UIView!
    @IBOutlet var colorPalette2: UIView!
    @IBOutlet var colorPalette3: UIView!
    @IBOutlet var colorPalette4: UIView!
    @IBOutlet var colorPalette5: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
