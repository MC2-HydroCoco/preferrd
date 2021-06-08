//
//  ColorCombination.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 08/06/21.
//

import Foundation

enum ColorCombination {
  case analogous
}

struct ColorSet {
  var baseColor: Color

  func getColorSet(for combination: ColorCombination) -> [String] {
    switch combination {
    case .analogous:
      // process
      return ["#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF"]
    }
  }
}

// Usage Example:
// let myColorSet = ColorSet(baseColor: .orange).getColorSet(for: .analogous)
