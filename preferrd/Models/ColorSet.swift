//
//  ColorSet.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 12/06/21.
//

import Foundation
import UIKit

struct ColorSet {
  static func from(_ baseColors: [UIColor]) -> [UIColor] {
    var colorSet: [UIColor] = [
      .white,
      .black
    ]

    baseColors.forEach { color in
      colorSet.append(contentsOf: [
        color.getTint(distance: 6.67),
        color.getTint(distance: 3.33),
        color,
        color.getShade(distance: 3.33),
        color.getShade(distance: 6.67)
      ])
    }

    return colorSet
  }

  static func filterContrastRatio(baseColor: String, from set: [UIColor], for type: ContrastRatioType) -> [UIColor] {
    set.filter { color in
      ColorHelper.getContrastRatio(rgb1: UIColor(hex: baseColor).toRGB(), rgb2: color.toRGB()) > type.rawValue
    }
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
