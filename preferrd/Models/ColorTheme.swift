//
//  ColorMeanings.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 07/06/21.
//

import Foundation
import UIKit

enum ColorTheme: String, CaseIterable {
    case relaxing     = "Relaxing",
         vintage      = "Vintage",
         happy        = "Happy",
         adventurous  = "Adventurous",
         modern       = "Modern",
         nature       = "Nature",
         fresh        = "Fresh",
         elegant      = "Elegant",
         feminine     = "Feminine",
         masculine    = "Masculine"
    
    func getImage() -> UIImage {
        switch self {
        case .relaxing:
            return #imageLiteral(resourceName: <#T##String#>)
        default:
            <#code#>
        }
    }
    
    static func getRelatedColors(for meaning: ColorTheme) -> [Color] {
        return Constants.colors.filter { $0.relatedTags.contains(meaning) }
    }
}
