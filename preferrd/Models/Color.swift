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

  func getColor() -> UIColor {
    switch self {
    case .red:
      return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    case .orange:
      return #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    case .yellow:
      return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    case .green:
      return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    case .blue:
      return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    case .black:
      return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
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
