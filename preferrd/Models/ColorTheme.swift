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
       playful      = "Playful",
       adventurous  = "Adventurous",
       modern       = "Modern",
       nature       = "Nature",
       fresh        = "Fresh",
       elegant      = "Elegant",
       feminine     = "Feminine",
       masculine    = "Masculine"

  func getImage() -> UIImage {
    switch self {
    case .adventurous:
      return #imageLiteral(resourceName: "Adventurous")
    case .elegant:
      return #imageLiteral(resourceName: "Elegant")
    case .fresh:
      return #imageLiteral(resourceName: "Fresh")
    case .playful:
      return #imageLiteral(resourceName: "Playful")
    case .modern:
      return #imageLiteral(resourceName: "Modern")
    case .nature:
      return #imageLiteral(resourceName: "Nature")
    case .relaxing:
      return #imageLiteral(resourceName: "Relaxing")
    case .vintage:
      return #imageLiteral(resourceName: "Modern")
    case .feminine:
      return #imageLiteral(resourceName: "Modern")
    case .masculine:
      return #imageLiteral(resourceName: "Modern")
    }
  }

  static func getRelatedColors(for meaning: ColorTheme) -> [Color] {
    return Constants.colors.filter { $0.relatedTags.contains(meaning) }
  }
}
