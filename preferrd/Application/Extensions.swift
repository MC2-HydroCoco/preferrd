//
//  Extensions.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 29/05/21.
//

import Foundation

extension String {
  // Call on any string and it'll return a translated string, if any.
  /// ex: let hello = "Hello World".localized
  /// if any translation for "Hello World" is specified,
  /// then, based on the device's language, you'll get the translated string.
  var localized: String {
    NSLocalizedString(self, comment: "")
  }
}

extension Array where Element: RawRepresentable {
  // dari ColorMeanings.allCases.map { "\($0.rawValue)" }
  // jadi ColorMeanings.allCases.rawValues
  // biar ✨clean✨
  var rawValues: [String] {
    self.map { "\($0.rawValue)" }
  }
}