//
//  BaseColorGroup.swift
//  preferrd
//
//  Created by Timothy Ananda on 15/06/21.
//

import Foundation

enum BaseColorGroup: String, CaseIterable {
    case red         = "Red",
         lightRed    = "Light Red",
         darkRed     = "Dark Red",
         brown       = "Brown",
         lightBrown  = "Light Brown",
         darkBrown   = "Dark Brown",
         orange      = "Orange",
         lightOrange = "Light Orange",
         darkOrange  = "Dark Orange",
         yellow      = "Yellow",
         lightYellow = "Light Yellow",
         green       = "Green",
         lightGreen  = "Light Green",
         darkGreen   = "Dark Green",
         blue        = "Blue",
         lightBlue   = "Light Blue",
         darkBlue    = "Dark Blue",
         purple      = "Purple",
         lightPurple = "Light Purple",
         darkPurple  = "Dark Purple",
         white       = "White",
         black       = "Black"
    
    func getRawBaseColor() -> String {
        let words = self.rawValue.byWords
        let lastWord = words.last ?? ""
        return String(lastWord)
    }
    
    func getColorMeaning() -> String {
        
    }
}
