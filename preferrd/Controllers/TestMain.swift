//
//  ViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 28/05/21.
//

import UIKit

class TestMain: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sortedColors: [Color] = {return Constants.colors}()
    
    var selectedEmotions =  [ColorTheme]()
    var relatedColors = [UIColor]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //    relatedColors = ColorCombination(baseColor: ColorMeaning.getRelatedColors(for: .fresh)[2].hex).triadic
        
//        selectedEmotions = [.elegant, .masculine]
        
        sortedColors.sort(by: {
                            UIColor(hex: $0.hex).getHueValue() < UIColor(hex: $1.hex).getHueValue()
        })
        print(sortedColors.count)
        
//        var tempHue: Float = 0
//        sortedColors.sort(by: {
////            print(UIColor(hex: $0.hex).getHueValue())
////            print(UIColor(hex: $0.hex).getHueValue() - UIColor(hex: $1.hex).getHueValue())
//            if (UIColor(hex: $0.hex).getHueValue() > Float(0.1) {
//                tempHue += Float(0.1)
//                return UIColor(hex: $0.hex).getSaturation() < UIColor(hex: $1.hex).getSaturation()
//            }
//            return false
//        })
    }
    
}

extension TestMain: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedColors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "relatedCell") as? RelatedColorCell {
            let color = sortedColors[indexPath.row]
            cell.colorPreview.backgroundColor = UIColor(hex: color.hex)
            cell.colorName.text = color.name
            cell.hexCode.text = color.hex
            var relatedTags = ""
            color.relatedTags.forEach { relatedTags += $0.rawValue }
            cell.relatedTags.text = relatedTags
//            cell.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
//            cell.colorName.textColor = UIColor.white
//            cell.hexCode.textColor = UIColor.white
//            cell.relatedTags.textColor = UIColor.white
            return cell
        }
        return UITableViewCell()
    }
    
}
