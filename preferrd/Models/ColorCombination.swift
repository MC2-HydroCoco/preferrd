//
//  ColorCombination.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 08/06/21.

/*
 Credit(s):
 - Computing Color Combination: https://stackoverflow.com/a/37060495/13449416
*/

import Foundation
import UIKit

enum ColorCombination {
  case analogous,
       complementary,
       splitComplementary,
       triadic,
       tertradic
}

struct ColorSet {
  let baseColor: UIColor

  init(baseColor: Color) {
    self.baseColor = baseColor.getColor()
  }

  var analogous: [UIColor] {
    let firstAnalogous  = baseColor.withHueOffset(offset: -1 / 12)
    let secondAnalogous = baseColor.withHueOffset(offset: 1 / 12)
    return [baseColor, firstAnalogous, secondAnalogous]
  }

   var complementary: [UIColor] {
    let complement = baseColor.withHueOffset(offset: 0.5)
    return [baseColor, complement]
  }

  var splitComplementary: [UIColor] {
    let firstSplitComplement = baseColor.withHueOffset(offset: 150 / 360)
    let secondSplitComplement = baseColor.withHueOffset(offset: 210 / 360)
    return [baseColor, firstSplitComplement, secondSplitComplement]
  }

  var triadic: [UIColor] {
    let firstTriadic  = baseColor.withHueOffset(offset: 120 / 360)
    let secondTriadic = baseColor.withHueOffset(offset: 240 / 360)
    return [firstTriadic, secondTriadic, baseColor]
  }

  var tetradic: [UIColor] {
    let firstTetradic = baseColor.withHueOffset(offset: 0.25)
    let secondTetradic = baseColor.withHueOffset(offset: 0.5)
    let thirdTetradic = baseColor.withHueOffset(offset: 0.75)
    return [firstTetradic, secondTetradic, thirdTetradic, baseColor]
  }
}
