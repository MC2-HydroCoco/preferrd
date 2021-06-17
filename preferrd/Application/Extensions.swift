//
//  Extensions.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 29/05/21.
//

import Foundation
import UIKit

extension String {
  // Call on any string and it'll return a translated string, if any.
  /// ex: let hello = "Hello World".localized
  /// if any translation for "Hello World" is specified,
  /// then, based on the device's language, you'll get the translated string.
  var localized: String {
    NSLocalizedString(self, comment: "")
  }
}

extension UIColor {

  // MARK: - Initialize UIColor from HEX Code
  convenience init(hex: String, alpha: CGFloat = 1.0) {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
      cString.remove(at: cString.startIndex)
    }

    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: alpha
    )
  }

  var hex: String {
    guard let components = self.cgColor.components else { fatalError("HEX: Error Getting Color Components.") }
    let red: CGFloat = components[0]
    let green: CGFloat = components[1]
    let blue: CGFloat = components[2]

    let hexString = String.init(
      format: "#%02lX%02lX%02lX",
      lroundf(Float(red * 255)),
      lroundf(Float(green * 255)),
      lroundf(Float(blue * 255))
    )
    return hexString
  }

  // MARK: - Color Combination Extensions
  func complement() -> UIColor {
    withHue(adjustedBy: 0.5)
  }

  func withHue(adjustedBy change: CGFloat) -> UIColor {

    guard (-1.0...1.0).contains(change) else {
      fatalError("Hue adjustment must be between 1.0 and -1.0")
    }

    var hue: CGFloat         = 0
    var saturation: CGFloat  = 0
    var brightness: CGFloat  = 0
    var alpha: CGFloat       = 0

    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    return UIColor(hue: fmod(hue + change, 1),
                   saturation: saturation,
                   brightness: brightness,
                   alpha: alpha)
  }

  func withSaturation(adjustedBy change: CGFloat,
                      floorAt floor: CGFloat = 0.0,
                      ceilingAt ceiling: CGFloat = 1.0,
                      withOverflow: Bool = false) -> UIColor {

    var hue: CGFloat         = 0
    var saturation: CGFloat  = 0
    var brightness: CGFloat  = 0
    var alpha: CGFloat       = 0

    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    var newSaturation = saturation + change

    if withOverflow {
      if newSaturation > ceiling {
        newSaturation -= ceiling-floor
      } else if newSaturation < floor {
        newSaturation += ceiling-floor
      }
    } else {
      if newSaturation > ceiling {
        newSaturation = ceiling
      } else if newSaturation < floor {
        newSaturation = floor
      }
    }

    return UIColor(hue: hue,
                   saturation: newSaturation,
                   brightness: brightness,
                   alpha: alpha)
  }

  func withBrightness(adjustedBy change: CGFloat,
                      floorAt floor: CGFloat = 0.0,
                      ceilingAt ceiling: CGFloat = 1.0,
                      withOverflow: Bool = false) -> UIColor {

    var hue: CGFloat         = 0
    var saturation: CGFloat  = 0
    var brightness: CGFloat  = 0
    var alpha: CGFloat       = 0

    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    var newBrightness = brightness + change

    if withOverflow {
      if newBrightness > ceiling {
        newBrightness -= ceiling-floor
      } else if newBrightness < floor {
        newBrightness += ceiling-floor
      }
    } else {
      if newBrightness > ceiling {
        newBrightness = ceiling
      } else if newBrightness < floor {
        newBrightness = floor
      }
    }

    return UIColor(hue: hue,
                   saturation: saturation,
                   brightness: newBrightness,
                   alpha: alpha)
  }

}

extension Array where Element == UIView? {
  func hide() {
    self.forEach { $0?.layer.opacity = 0 }
  }
}
