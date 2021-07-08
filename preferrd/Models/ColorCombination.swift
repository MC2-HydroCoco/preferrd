//
//  ColorCombination.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 08/06/21.

/*
 Credit(s):
 - Primary Source for Computing Color Combination(s): https://github.com/dunesailer/Aesthete
 // Not so useful, eventually.
 - Computing Color Combination: https://stackoverflow.com/a/37060495/13449416
 - Generate Extra Combination: https://github.com/bennyguitar/Colours/blob/master/Colours.swift
 */

// swiftlint:disable function_body_length

import Foundation
import UIKit

enum ColorCombination: String, CaseIterable {
  case analogous          = "Analogous",
       accentedAnalogous  = "Accented Analogous",
       complementary      = "Complementary",
       splitComplementary = "Split Complementary",
       monochromatic      = "Monochromatic",
       compound           = "Compound",
       triadic            = "Triadic"

  func getCombination(from baseColor: UIColor) -> [UIColor] {
    let spacing: CGFloat = 0.05

    switch self {
    case .analogous:
      return [
        baseColor,
        baseColor
          .withSaturation(adjustedBy: -0.05, floorAt: 0.1)
          .withHue(adjustedBy: spacing)
          .withBrightness(adjustedBy: -0.05, floorAt: 0.2),
        baseColor
          .withSaturation(adjustedBy: -0.05, floorAt: 0.1)
          .withHue(adjustedBy: spacing * 2)
          .withBrightness(adjustedBy: 0, floorAt: 0.2),
        baseColor
          .withSaturation(adjustedBy: -0.05, floorAt: 0.1)
          .withHue(adjustedBy: -spacing)
          .withBrightness(adjustedBy: -0.05, floorAt: 0.2),
        baseColor
          .withSaturation(adjustedBy: -0.05, floorAt: 0.1)
          .withHue(adjustedBy: -(spacing * 2))
          .withBrightness(adjustedBy: 0, floorAt: 0.2)
      ]
    case .accentedAnalogous:
      return [
        baseColor,
        baseColor
          .withSaturation(adjustedBy: -0.05, floorAt: 0.10)
          .withHue(adjustedBy: spacing).withBrightness(adjustedBy: -0.05, floorAt: 0.20),
        baseColor
          .withSaturation(adjustedBy: -0.05, floorAt: 0.10)
          .withHue(adjustedBy: -spacing)
          .withBrightness(adjustedBy: -0.05, floorAt: 0.20),
        baseColor
          .withSaturation(adjustedBy: -0.05, floorAt: 0.10)
          .withHue(adjustedBy: spacing*2).complement()
          .withBrightness(adjustedBy: 0, floorAt: 0.20),
        baseColor
          .withSaturation(adjustedBy: -0.05, floorAt: 0.10)
          .withHue(adjustedBy: -(spacing*2)).complement()
          .withBrightness(adjustedBy: 0, floorAt: 0.20)
      ]
    case .complementary:
      return [
        baseColor,
        baseColor
          .withSaturation(adjustedBy: 0.10)
          .withBrightness(adjustedBy: -0.30, floorAt: 0.20, withOverflow: true),
        baseColor
          .withSaturation(adjustedBy: -0.10)
          .withBrightness(adjustedBy: 0.30),
        baseColor
          .complement()
          .withSaturation(adjustedBy: 0.20)
          .withBrightness(adjustedBy: -0.30, floorAt: 0.20, withOverflow: true),
        baseColor
          .complement()
      ]
    case .splitComplementary:
      return [
        baseColor,
        baseColor
          .withSaturation(adjustedBy: 0.10)
          .withBrightness(adjustedBy: -0.30, floorAt: 0.20, withOverflow: true),
        baseColor
          .withSaturation(adjustedBy: -0.10)
          .withBrightness(adjustedBy: 0.30),
        baseColor
          .complement()
          .withHue(adjustedBy: spacing),
        baseColor
          .complement()
          .withHue(adjustedBy: -spacing)
      ]
    case .monochromatic:
      return [
        baseColor,
        baseColor
          .withBrightness(adjustedBy: -0.50, floorAt: 0.20, withOverflow: true),
        baseColor
          .withSaturation(adjustedBy: -0.30, floorAt: 0.10, ceilingAt: 0.70, withOverflow: true),
        baseColor
          .withBrightness(adjustedBy: -0.50, floorAt: 0.20, withOverflow: true)
          .withSaturation(adjustedBy: -0.3, floorAt: 0.10, ceilingAt: 0.70, withOverflow: true),
        baseColor
          .withBrightness(adjustedBy: -0.20, floorAt: 0.20, withOverflow: true)
      ]
    case .compound:
      return [
        baseColor,
        baseColor
          .withHue(adjustedBy: 0.1)
          .withSaturation(adjustedBy: -0.10, floorAt: 0.10)
          .withBrightness(adjustedBy: -0.20, floorAt: 0.20),
        baseColor
          .withHue(adjustedBy: 0.1)
          .withSaturation(adjustedBy: -0.40, floorAt: 0.10, ceilingAt: 0.90)
          .withBrightness(adjustedBy: -0.40, floorAt: 0.20),
        baseColor
          .withHue(adjustedBy: -0.05).complement()
          .withSaturation(adjustedBy: -0.25, floorAt: 0.10)
          .withBrightness(adjustedBy: 0.05, floorAt: 0.20),
        baseColor
          .withHue(adjustedBy: -0.1).complement()
          .withSaturation(adjustedBy: 0.10, ceilingAt: 0.90)
          .withBrightness(adjustedBy: -0.20, floorAt: 0.20)
      ]
    case .triadic:
      return [
        baseColor,
        baseColor
          .withSaturation(adjustedBy: 0.10)
          .withBrightness(adjustedBy: -0.30, floorAt: 0.20, withOverflow: true),
        baseColor
          .withHue(adjustedBy: 0.33)
          .withSaturation(adjustedBy: -0.10),
        baseColor
          .withHue(adjustedBy: 0.66)
          .withSaturation(adjustedBy: -0.10)
          .withBrightness(adjustedBy: -0.20),
        baseColor
          .withHue(adjustedBy: 0.66)
          .withSaturation(adjustedBy: -0.05)
          .withBrightness(adjustedBy: -0.30, floorAt: 0.40, withOverflow: true)
      ]
    }
  }

  var description: String {
    switch self {
    case .analogous:
      return "combination.detail.analogous".localized
    case .accentedAnalogous:
      return "combination.detail.accented_analogous".localized
    case .complementary:
      return "combination.detail.complementary".localized
    case .splitComplementary:
      return "combination.detail.split_complementary".localized
    case .monochromatic:
      return "combination.detail.monochromatic".localized
    case .compound:
      return "combination.detail.compound".localized
    case .triadic:
      return "combination.detail.triadic".localized
    }
  }
}
