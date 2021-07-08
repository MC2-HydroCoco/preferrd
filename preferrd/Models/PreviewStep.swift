//
//  PreviewStep.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 15/06/21.
//

// swiftlint:disable line_length

import Foundation

enum PreviewStep: String, CaseIterable {
  case background = "preview.title.background",
       title      = "preview.title.title",
       body       = "preview.title.body",
       button     = "preview.title.button",
       buttonText = "preview.title.button_text"

  var title: String {
    self.rawValue.localized
  }

  var detail: String {
    switch self {
    case .background:
      return "preview.detail.background".localized
    case .title:
      return "preview.detail.title".localized
    case .body:
      return "preview.detail.body".localized
    case .button:
      return "preview.detail.button".localized
    case .buttonText:
      return "preview.detail.button_text".localized
    }
  }
}
