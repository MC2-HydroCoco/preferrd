//
//  ColorTableViewCell.swift
//  preferrd
//
//  Created by Michelle Linus on 10/06/21.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    //Required Payload
    var baseColor: Color! = Constants.colors[1] {
        didSet {
            colorCollection.reloadData()
        }
    }

    @IBOutlet var colorInfoButton: UIButton!
    @IBOutlet weak var colorBox: UIView!
    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var colorHex: UILabel!
    @IBOutlet weak var colorBackground: UIView!
    @IBOutlet var colorCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBaseColor()
    }
    
    func setupBaseColor() {
        colorBackground.layer.cornerRadius = 12
        colorBox.layer.cornerRadius = 12
        
        colorCollection.delegate = self
        colorCollection.dataSource = self
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
}

extension ColorTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        baseColor.relatedTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "relatedTag",
            for: indexPath
        ) as? RelatedTagCollectionViewCell {
            cell.tagLabel.text = baseColor.relatedTags[indexPath.item].rawValue
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
