//
//  Color.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 08/06/21.
//

import Foundation
import UIKit

enum Color: String, CaseIterable {
  case red     = "Red",
       orange  = "Orange",
       yellow  = "Yellow",
       green   = "Green",
       blue    = "Blue",
       black   = "Black"

  var hex: String {
    switch self {
    case .red:
      return "#FF0000"
    case .orange:
      return "#FFA500"
    case .yellow:
      return "#FFFF00"
    case .green:
      return "#008000"
    case .blue:
      return "#0000FF"
    case .black:
      return "#000000"
    }
  }

  func getColor() -> UIColor {
    UIColor(hex: self.hex)
  }

  func getTags() -> [String] {
    switch self {
    case .red:
      return []
    case .orange:
      return []
    case .yellow:
      return []
    case .green:
      return []
    case .blue:
      return [
        ColorMeanings.relaxing
      ].rawValues
    case .black:
      return [
        ColorMeanings.elegant,
        ColorMeanings.modern
      ].rawValues
    }
  }

  static func getAllColors() -> [String] {
    Color.allCases.rawValues
  }
}
