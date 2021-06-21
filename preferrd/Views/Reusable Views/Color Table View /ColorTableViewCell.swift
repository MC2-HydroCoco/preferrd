//
//  ColorTableViewCell.swift
//  preferrd
//
//  Created by Michelle Linus on 10/06/21.
//

import UIKit

class ColorTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
//    func generateTag(colorName: String) -> [String] {
//        var tagColor = Color.
//    }
//    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // banyaknya tag in integer
        return 3
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCollectionCell", for: indexPath) as? TagsCollectionViewCell {
            
            // label tag text generate dari tagnya color
            
            cell.tagLabel.text = "fandika"
            return cell
        }
        return UICollectionViewCell()
    }
    

    @IBOutlet var colorInfoButton: UIButton!
    @IBOutlet weak var colorBox: UIView!
    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var colorHex: UILabel!
    @IBOutlet weak var colorBackground: UIView!
    @IBOutlet var colorCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorBackground.layer.cornerRadius = 12
        colorBox.layer.cornerRadius = 12
        
        colorCollection.register(tagNib, forCellWithReuseIdentifier: "colorCollectionCell")
        
        colorCollection.dataSource = self
        colorCollection.delegate = self
        
    }

    @IBAction func colorInformation(_ sender: UIButton) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    let tagNib = UINib(nibName: "\(TagsCollectionViewCell.self)", bundle: nil)
    
    
    
    
}
