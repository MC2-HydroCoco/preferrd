//
//  Color.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 08/06/21.

import Foundation
import UIKit

struct Color {
  let name, hex, colorDescription: String
  let relatedTags: [ColorTheme]

  init(name: String, hex: String, colorDescription: String = "", relatedTags: [ColorTheme]) {
    self.name = name
    self.hex = hex
    self.colorDescription = colorDescription
    self.relatedTags = relatedTags
  }
}
