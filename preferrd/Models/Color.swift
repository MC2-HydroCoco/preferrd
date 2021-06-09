//
//  Color.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 08/06/21.
//

import Foundation
import UIKit

enum Color: String, CaseIterable {
  case red     = "Red",
       orange  = "Orange",
       yellow  = "Yellow",
       green   = "Green",
       blue    = "Blue",
       black   = "Black"

  var hex: String {
    switch self {
    case .red:
      return "#FF0000"
    case .orange:
      return "#FFA500"
    case .yellow:
      return "#FFFF00"
    case .green:
      return "#008000"
    case .blue:
      return "#0000FF"
    case .black:
      return "#000000"
    }
  }

  var description: String {
    switch self {
    case .red:
      return "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    case .orange:
      return "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    case .yellow:
      return "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    case .green:
      return "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    case .blue:
      return "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    case .black:
      return "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    }
  }

  func getUIColor() -> UIColor {
    UIColor(hex: self.hex)
  }

  func getTags() -> [String] {
    switch self {
    case .red:
      return [
        ColorMeaning.fresh
      ].rawValues
    case .orange:
      return [
        ColorMeaning.fresh
      ].rawValues
    case .yellow:
      return [
        ColorMeaning.fresh
      ].rawValues
    case .green:
      return [
        ColorMeaning.fresh
      ].rawValues
    case .blue:
      return [
        ColorMeaning.relaxing
      ].rawValues
    case .black:
      return [
        ColorMeaning.elegant,
        ColorMeaning.modern
      ].rawValues
    }
  }
}
