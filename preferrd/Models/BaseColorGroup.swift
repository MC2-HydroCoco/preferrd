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
         black       = "Black",
         gray        = "Gray"
    
    func getRawBaseColor() -> String {
//        return self.rawValue.suffix(1)
    }
    
    func getColorMeaning() -> String {
        switch self {
        case .red:
            return "Energy, war, danger, strength, power, determination, action, confidence, courage, vitality, passion, desire, and love. It can enhance metabolism, increase respiration, and raise blood pressure"
        case .lightRed:
            return "Joy, sexuality, passion, sensitivity, love, romance, friendship, feminine qualities and passiveness."
        case .darkRed:
            return "Vigor, willpower, rage, anger, leadership, courage, longing, malice, and wrath. "
        case .brown:
            return "Material things, order, convention, stability, solid, wholesome feeling. "
        case .lightBrown:
            return "Friendly, welcoming, honest, sincere genuine, practical, reliable, conservative and loyal. "
        case .darkBrown:
            return "Strong, but sometimes also sad and depressing"
        case .orange:
            return "Joy, sunshine, the tropics, enthusiasm, happiness, fascination, creativity, determination, attraction, success, encouragement, stimulation, and strength"
        case .lightOrange:
            return "Prestige, wisdom, illumination, wealth, and quality this is more of a golden ish orange while light orange represent friendly and soothing."
        case .darkOrange:
            return "Deceit and distrust, it's quite relative to the color combination, it could support backgrounds or even give a positive quality such as bold when combined well with the right color combination"
        case .yellow:
            return "Joy, happiness, wisdom, and intellectual energy. It stimulates mental activity and generates muscle energy."
        case .lightYellow:
            return "Warmth and energy. Other positive associations with the hue include happiness, hope and fun."
        case .green:
            return "Nature, healing, stability, endurance, harmony, safety, life, and well being"
        case .lightGreen:
            return "Nature, confidence, and high energy and is thought to promote feelings of liveliness, freshness, and creativity"
        case .darkGreen:
            return "Greed, ambition, and wealth"
        case .blue:
            return "Trust, loyalty, wisdom, intelligence, expertise, confidence, stability and depth"
        case .lightBlue:
            return "Cleanliness, strength, dependability, coolness, peace, serenity, ethereal, spiritual, infinity."
        case .darkBlue:
            return "Trust, dignity, intelligence, authority"
        case .purple:
            return "Purple is associated with wisdom, dignity, independence, riches, royalty, creativity, mystery, and magic"
        case .lightPurple:
            return "Feminine energy and delicacy, as well as romantic and nostalgic feelings"
        case .darkPurple:
            return "Gloom, sadness, and frustration."
        case .black:
            return "Power, elegance, formality, death, evil, and mystery. It denotes strength and authority, is seen as formal and elegant, and brings forth feelings of fear and the unknown"
        case .white:
            return "Safety, purity, freshness, cleanliness, innocence, simplicity."
        case .gray:
            return "Sorrow, detachment, and isolation. It connotes responsibility and conservative practicality, it's a neutral color and creates a non-invasive feeling. It’s can be associated with security, maturity, and dependability. "
        }
    }
}
