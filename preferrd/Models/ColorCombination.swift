//
//  ColorCombination.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 08/06/21.

/*
 Credit(s):
 - Computing Color Combination: https://stackoverflow.com/a/37060495/13449416
 - Generate Extra Combination: https://github.com/bennyguitar/Colours/blob/master/Colours.swift
 */

import Foundation
import UIKit

struct ColorCombination {
  let baseColor: UIColor

  init(baseColor: String) {
    self.baseColor = UIColor(hex: baseColor)
  }

  var analogous: [UIColor] {
    return [
      baseColor.offset(hue: 18 / 360, saturation: 0.05, brightness: 0.05),
      baseColor.offset(hue: 9 / 360, saturation: 0.05, brightness: 0.09),
      baseColor,
      baseColor.multiply(hue: 10 / 3).offset(hue: 330 / 360, saturation: 0.05, brightness: 0.09),
      baseColor.multiply(hue: 10 / 3).offset(hue: 300 / 360, saturation: 0.05, brightness: 0.05)
    ]
  }

  var monochromatic: [UIColor] {
    return [
      baseColor.offset(brightness: 0.5),
      baseColor.offset(saturation: 0.3),
      baseColor,
      baseColor.offset(saturation: 0.3, brightness: 0.5),
      baseColor.offset(brightness: 0.2)
    ]
  }

  var complementary: [UIColor] {
    return [
      baseColor.multiply(hue: 2).offset(saturation: 0.1, brightness: 0.3),
      baseColor.offset(saturation: -0.1, brightness: 0.3),
      baseColor,
      baseColor.multiply(hue: 2).offset(hue: 137 / 360, saturation: 0.2, brightness: 0.3),
      baseColor.offset(hue: 137 / 360)
    ]
  }

  var splitComplementary: [UIColor] {
    return [
      baseColor.multiply(hue: 2.1).offset(hue: 100 / 360, saturation: 0.1, brightness: 0.3),
      baseColor.multiply(hue: 2.1).offset(hue: 100 / 360, saturation: 0.05),
      baseColor,
      baseColor.multiply(hue: 1.9).offset(hue: 171 / 360, saturation: 0.1, brightness: 0.3),
      baseColor.multiply(hue: 1.9).offset(hue: 171 / 360, saturation: 0.1)
    ]
  }

  var triadic: [UIColor] {
    return [
      baseColor.offset(saturation: 0.1, brightness: 0.3),
      baseColor.multiply(hue: 2).offset(hue: 60 / 360, saturation: 0.1),
      baseColor,
      baseColor.multiply(hue: 2).offset(hue: 205 / 360, saturation: 0.1),
      baseColor.multiply(hue: 2).offset(hue: 205 / 360, saturation: 0.1, brightness: 0.3)
    ]
  }
}

extension UIColor {
  func offset(hue hOffset: CGFloat = 0, saturation sOffset: CGFloat = 0, brightness bOffset: CGFloat = 0) -> UIColor {

    var hue: CGFloat         = 0
    var saturation: CGFloat  = 0
    var brightness: CGFloat  = 0
    var alpha: CGFloat       = 0

    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    return UIColor(hue: fmod(hue + hOffset, 1),
                   saturation: saturation + sOffset,
                   brightness: brightness < 0.5 ? brightness + bOffset : brightness - bOffset,
                   alpha: alpha)
  }

  func multiply(hue hMultiplier: CGFloat = 1,
                saturation sMultiplier: CGFloat = 1,
                brightness bMultiplier: CGFloat = 1,
                alpha aMultiplier: CGFloat = 1) -> UIColor {

    var hue: CGFloat         = 0
    var saturation: CGFloat  = 0
    var brightness: CGFloat  = 0
    var alpha: CGFloat       = 0

    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    return UIColor(hue: fmod(hue * hMultiplier, 1),
                   saturation: saturation * sMultiplier,
                   brightness: brightness * bMultiplier,
                   alpha: alpha * aMultiplier)
  }
}
