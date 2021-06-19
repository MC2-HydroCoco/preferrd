//
//  ColorSet.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 12/06/21.
//
//  Credit(s):
//  - Generate Tints & Shades: https://github.com/edelstone/tints-and-shades/blob/master/scripts/tints-and-shades.js

import Foundation
import UIKit

struct ColorSet {
  static func generate(from baseColors: [UIColor]) -> [UIColor] {
    var colorSet: [UIColor] = [
      UIColor(hex: "#F7F7F7"),
      UIColor(hex: "#222222")
    ]

    baseColors.forEach { color in
      colorSet.append(contentsOf: [
        color.getTint(distance: 5),
        color.getTint(distance: 3),
        color,
        color.getShade(distance: 3)
      ])
    }

    return colorSet
  }

  static func filterContrastRatio(baseColor: UIColor, from set: [UIColor], for type: ContrastRatioType) -> [Int] {
    var validColorsIndex = [Int]()
    set.enumerated().forEach { (index, color) in
      if ColorHelper.getContrastRatio(between: baseColor.toRGB(), and: color.toRGB()) > type.rawValue {
        validColorsIndex.append(index)
      }
    }
    return validColorsIndex
  }
}

extension UIColor {
  func getTint(distance: CGFloat) -> UIColor {
    var red: CGFloat    = 0,
        green: CGFloat  = 0,
        blue: CGFloat   = 0,
        alpha: CGFloat  = 0
    getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    let distance: CGFloat = (0.1 * distance)

    return UIColor(red: red + (1 - red) * distance,
                   green: green + (1 - green) * distance,
                   blue: blue + (1 - blue) * distance,
                   alpha: alpha)
  }

  func getShade(distance: CGFloat) -> UIColor {
    var red: CGFloat    = 0,
        green: CGFloat  = 0,
        blue: CGFloat   = 0,
        alpha: CGFloat  = 0
    getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    let distance: CGFloat = (1 - 0.1 * distance)

    return UIColor(red: red * distance,
                   green: green * distance,
                   blue: blue * distance,
                   alpha: alpha)
  }
}
