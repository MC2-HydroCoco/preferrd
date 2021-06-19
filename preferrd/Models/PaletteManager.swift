//
//  PaletteManager.swift
//  preferrd
//
//  Created by Timothy Ananda on 16/06/21.
//
// swiftlint:disable force_cast
// swiftlint:disable function_parameter_count

import UIKit
import CoreData

struct PaletteManager {
  static let shared = PaletteManager()
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

  func fetch() -> [Palette] {
    var palettes = [Palette]()

    do {
      let request: NSFetchRequest<Palette> = Palette.fetchRequest()

      palettes = try context.fetch(request)
    } catch {
      print(error.localizedDescription)
    }

    return palettes
  }

  func removeAll() {
    let palettes = self.fetch()
    palettes.forEach {
      context.delete($0)
    }

    do {
      try context.save()
    } catch {
      print(error.localizedDescription)
    }
  }

  func add(name: String,
           backgroundHex: String,
           headlineHex: String,
           bodyHex: String,
           buttonBgHex: String,
           buttonTextHex: String) {

    let palette = Palette(context: context)
    self.setVariables(
      to: palette,
      name: name,
      backgroundHex: backgroundHex,
      headlineHex: headlineHex,
      bodyHex: bodyHex,
      buttonBgHex: buttonBgHex,
      buttonTextHex: buttonTextHex
    )

    do {
      try context.save()
    } catch {
      print(error.localizedDescription)
    }
  }

  func update(palette: Palette,
              name: String,
              backgroundHex: String,
              headlineHex: String,
              bodyHex: String,
              buttonBgHex: String,
              buttonTextHex: String) {
    self.setVariables(
      to: palette,
      name: name,
      backgroundHex: backgroundHex,
      headlineHex: headlineHex,
      bodyHex: bodyHex,
      buttonBgHex: buttonBgHex,
      buttonTextHex: buttonTextHex
    )

    do {
      try context.save()
    } catch {
      print(error.localizedDescription)
    }
  }

  func remove(palette: Palette) {
    context.delete(palette)

    do {
      try context.save()
    } catch {
      print(error.localizedDescription)
    }
  }

  func setVariables(to palette: Palette,
                    name: String,
                    backgroundHex: String,
                    headlineHex: String,
                    bodyHex: String,
                    buttonBgHex: String,
                    buttonTextHex: String) {
    palette.name = name
    palette.backgroundHex = backgroundHex
    palette.headlineHex = headlineHex
    palette.bodyHex = bodyHex
    palette.buttonBgHex = buttonBgHex
    palette.buttonTextHex = buttonTextHex
  }
}
