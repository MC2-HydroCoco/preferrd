//
//  ColorMeanings.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 07/06/21.
//

import Foundation

enum ColorMeanings: String, CaseIterable {
  case relaxing     = "Relaxing",
       vintage      = "Vintage",
       happy        = "Happy",
       adventurous  = "Adventurous",
       modern       = "Modern",
       nature       = "Nature",
       fresh        = "Fresh",
       elegant      = "Elegant"

  func getRelatedColors() -> [Color] {
    switch self {
    case .relaxing:
      return [.blue]
    case .vintage:
      return []
    case .happy:
      return []
    case .adventurous:
      return []
    case .modern:
      return [.black]
    case .nature:
      return []
    case .fresh:
      return []
    case .elegant:
      return [.black]
    }
  }

  static func getAllColorMeanings() -> [String] {
    ColorMeanings.allCases.rawValues
  }
}
