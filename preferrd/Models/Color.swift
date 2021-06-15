import Foundation

struct Color {
  let name, hex, colorDescription: String
  let relatedTags: [ColorMeaning]
//    let colorRange: [ColorRange]

  init(name: String, hex: String, colorDescription: String = "", relatedTags: [ColorMeaning]) {
    self.name = name
    self.hex = hex
    self.colorDescription = colorDescription
    self.relatedTags = relatedTags
  }
}
