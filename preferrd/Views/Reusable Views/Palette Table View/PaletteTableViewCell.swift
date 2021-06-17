//
//  PaletteTableViewCell.swift
//  preferrd
//
//  Created by Fandika Ikhsan on 10/06/21.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {

    @IBOutlet weak var paletteBackgroundView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var backgroundColorView: UIView!
    @IBOutlet var headlineColorView: UIView!
    @IBOutlet var bodyColorView: UIView!
    @IBOutlet var buttonBgView: UIView!
    @IBOutlet var buttonTextView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        paletteBackgroundView.layer.cornerRadius = 12
        paletteBackgroundView.layer.shadowColor = UIColor.black.cgColor
        paletteBackgroundView.layer.shadowOpacity = 0.4
        paletteBackgroundView.layer.shadowOffset = CGSize(width: 4, height: 4)
        paletteBackgroundView.layer.shadowRadius = 5
        
        backgroundColorView.layer.cornerRadius = 12
        backgroundColorView.layer.borderColor = UIColor.black.cgColor
        backgroundColorView.layer.borderWidth = 0.2
        
        headlineColorView.layer.cornerRadius = 12
        headlineColorView.layer.borderColor = UIColor.black.cgColor
        headlineColorView.layer.borderWidth = 0.2
        
        bodyColorView.layer.cornerRadius = 12
        bodyColorView.layer.borderColor = UIColor.black.cgColor
        bodyColorView.layer.borderWidth = 0.2
        
        buttonBgView.layer.cornerRadius = 12
        buttonBgView.layer.borderColor = UIColor.black.cgColor
        buttonBgView.layer.borderWidth = 0.2
        
        buttonTextView.layer.cornerRadius = 12
        buttonTextView.layer.borderColor = UIColor.black.cgColor
        buttonTextView.layer.borderWidth = 0.2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
