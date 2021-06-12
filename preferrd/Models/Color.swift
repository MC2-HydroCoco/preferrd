//
//  Color.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 08/06/21.

//  Credit(s):
//  - Generate Tints & Shades: https://github.com/edelstone/tints-and-shades/blob/master/scripts/tints-and-shades.js

import Foundation
import UIKit

struct Color {
  let name, hex, colorDescription: String
  let relatedTags: [ColorMeaning]

  init(name: String, hex: String, colorDescription: String = "", relatedTags: [ColorMeaning]) {
    self.name = name
    self.hex = hex
    self.colorDescription = colorDescription
    self.relatedTags = relatedTags
  }
}
