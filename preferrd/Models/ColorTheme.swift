//
//  ColorMeanings.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 07/06/21.
//

import Foundation
import UIKit

enum ColorTheme: String, CaseIterable {
  case relaxing     = "theme.relaxing",
       vintage      = "theme.vintage",
       playful      = "theme.playful",
       adventurous  = "theme.adventurous",
       modern       = "theme.modern",
       nature       = "theme.nature",
       fresh        = "theme.fresh",
       elegant      = "theme.elegant",
       feminine     = "theme.feminine",
       masculine    = "theme.masculine"

  var locale: String {
    self.rawValue.localized
  }

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
