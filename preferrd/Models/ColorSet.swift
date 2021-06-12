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
}
