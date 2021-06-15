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

enum ColorCombination: String {
    case analogous          = "Analogous",
         accentedAnalogous  = "Accented Analogous",
         complementary      = "Complementary",
         splitComplementary = "Split Complementary",
         monochromatic      = "Monochromatic",
         compound           = "Compound",
         triadic            = "Triadic",
         shades             = "Shades"
    
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
        case .shades:
            return [
                baseColor,
                baseColor.withBrightness(adjustedBy: -0.25, floorAt: 0.20, withOverflow: true),
                baseColor.withBrightness(adjustedBy: -0.50, floorAt: 0.20, withOverflow: true),
                baseColor.withBrightness(adjustedBy: -0.75, floorAt: 0.20, withOverflow: true),
                baseColor.withBrightness(adjustedBy: -0.10, floorAt: 0.20)
            ]
        }
    }
    
    func getMeaning() -> String {
        switch self {
        case .analogous:
            return "The color grouping has similarities. These color scheme types have close relationships to one another, the range of colors in the color wheel are side by side."
        case .accentedAnalogous:
            return "An accented analogous scheme (also called analogous complementary) is a combination of the analogous and complementary color schemes. It consists of colors which sit next to each other on the color wheel and a color that is directly opposite to these."
        case .complementary:
            return "Complementary colors are pairs of colors which, when combined or mixed, cancel each other out (lose hue) by producing a grayscale color like white or black. When placed next to each other, they create the strongest contrast for those two colors. Complementary colors may also be called opposite colors."
        case .splitComplementary:
            return "split-complementary color, is a mix together one primary color and two colors adjacent to its complement. While complementary colors tend to look dull, split-complementary colors are used well for contrast purposes."
        case .monochromatic:
            return "Monochromatic colors are all the colors of a single hue. Monochromatic color schemes are derived from a single base hue and extended using its shades, tones and tints."
        case .compound:
            return "This combination is made up of one color and the colors on either side of the complement. This strategy adds more variety than complementary color schemes by including three hues, without being too jarring or too bold."
        case .triadic:
            return "A triadic color scheme is comprised of three colors evenly spaced on the color wheel. The two most basic triadic palettes are the primary colors red, blue, and yellow and the secondary hues orange, purple, and green."
        case .shades:
            return ""
        }
    }
}
