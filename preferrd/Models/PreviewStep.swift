//
//  PreviewStep.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 15/06/21.
//

// swiftlint:disable line_length

import Foundation

enum PreviewStep: CaseIterable {
  case background,
       title,
       body,
       button,
       buttonText

  var title: String {
    switch self {
    case .background:
      return "Background Color"
    case .title:
      return "Title Color"
    case .body:
      return "Body Color"
    case .button:
      return "Button Color"
    case .buttonText:
      return "Button Text Color"
    }
  }

  var detail: String {
    switch self {
    case .background:
      return "A Background will establish the base and the accent color for your application, Make sure you make the most of it and it’s best to pick the lightest color or the darkest so the elements for the UI can be well distributed."
    case .title:
      return "A Headline, should have the biggest contrast than the background, and it should also have the biggest weight than captions and bodycopy so it can establish a good information Hierarchy."
    case .body:
      return "A body copy can have a slight difference with the title or headlines, but make sure they still have high contrast than the background."
    case .button:
      return "A Button shape color should have a big contrast with the background just like bodycopy, if the background is mainly dark color make sure the button shape is light colored and vice versa!"
    case .buttonText:
      return "A Button Text just like bodycopy, needs to have high contrast between shape and button text, so just like before, if the button shape color is bright choose a dark colored text and vice versa."
    }
  }
}
