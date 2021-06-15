//
//  ColorContrast.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 01/06/21.
//

import Foundation
import UIKit

// Usage Example
/*
 let first = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).toRGB()
 let second = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).toRGB()

 let ratio = ColorHelper.getContrastRatio(rgb1: first, rgb2: second) // 1
 */

struct ColorHelper {

  static func getLuminance(red: Double, green: Double, blue: Double) -> Double {
    var luminances = [red, green, blue]

    luminances = luminances.map { (value: Double) in
      if value <= 0.03928 {
        return value / 12.92
      } else {
        return Double(pow((value + 0.055) / 1.055, 2.4))
      }
    }

    return luminances[0] * 0.2126 + luminances[1] * 0.7152 + luminances[2] * 0.0722
  }

  static func getContrastRatio(rgb1: [Double], rgb2: [Double]) -> Double {
    let lum1 = getLuminance(red: rgb1[0], green: rgb1[1], blue: rgb1[2])
    let lum2 = getLuminance(red: rgb2[0], green: rgb2[1], blue: rgb2[2])
    let brightest = Double(max(lum1, lum2))
    let darkest = Double(min(lum1, lum2))

    return (brightest + 0.05) / (darkest + 0.05)
  }
}

extension UIColor {
  func toRGB() -> [Double] {
    var red: CGFloat    = 0
    var green: CGFloat  = 0
    var blue: CGFloat   = 0
    var alpha: CGFloat  = 0

    getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    return [Double(red), Double(green), Double(blue)]
  }

  func modify(saturation modifiedSaturation: Float = -1,
              brightness modifiedBrightness: Float = -1) -> UIColor {
    var hue: CGFloat        = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat      = 0

    getHue(&hue,
           saturation: &saturation,
           brightness: &brightness,
           alpha: &alpha)

    saturation = modifiedSaturation != -1 ? CGFloat(modifiedSaturation) : saturation
    brightness = modifiedBrightness != -1 ? CGFloat(modifiedBrightness) : brightness

    return UIColor(hue: hue,
                   saturation: saturation,
                   brightness: brightness,
                   alpha: alpha)
  }
    
    func getHueValue() -> Float {
        var hue: CGFloat        = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat      = 0

        getHue(&hue,
               saturation: &saturation,
               brightness: &brightness,
               alpha: &alpha)

        return Float(hue)
    }

  func getSaturation() -> Float {
    var hue: CGFloat        = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat      = 0

    getHue(&hue,
           saturation: &saturation,
           brightness: &brightness,
           alpha: &alpha)

    return Float(saturation)
  }

  func getBrightness() -> Float {
    var hue: CGFloat        = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat      = 0

    getHue(&hue,
           saturation: &saturation,
           brightness: &brightness,
           alpha: &alpha)

    return Float(brightness)
  }
}
