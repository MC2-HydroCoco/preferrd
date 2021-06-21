//
//  ColorTableViewCell.swift
//  preferrd
//
//  Created by Michelle Linus on 10/06/21.
//

import UIKit

func thisCellColor(colorText:String) -> [Color] {
    Constants.colors.filter{$0.name.contains("\(colorText)")}
}

let colorTags = ["a", "b"]





class ColorTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
//    func generateTag(colorName: String) -> [String] {
//        var tagColor = Color.
//    }
//
    
    // generate color detail dari colorName
    //
    var color: Color!

    
    @IBOutlet var colorInfoButton: UIButton!
    @IBOutlet weak var colorBox: UIView!
    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var colorHex: UILabel!
    @IBOutlet weak var colorBackground: UIView!
    @IBOutlet var colorCollection: UICollectionView!
    
    override func awakeFromNib() {
        
        print("fandikaa\(thisCellColor(colorText: "Alabaster"))")
        
        
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
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return color.relatedTags.count
        
        // banyaknya tag in integer
//        return thisCellColor(colorText: colorName.text).
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCollectionCell", for: indexPath) as? TagsCollectionViewCell {
            
            // label tag text generate dari tagnya color
            cell.tagLabel.text = color.relatedTags[indexPath.row].rawValue
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
