//
//  TagsCollectionViewCell.swift
//  preferrd
//
//  Created by Fandika Ikhsan on 17/06/21.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {

    @IBOutlet var tagViews: UIView!
    @IBOutlet var tagBackgroundViews: UIView!
    @IBOutlet var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tagBackgroundViews.layer.cornerRadius = 12
    }

    
}
