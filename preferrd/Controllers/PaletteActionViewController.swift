//
//  PaletteActionViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 18/06/21.
//

import UIKit

class PaletteActionViewController: UIViewController {

  var payload = [String: String]()
  var nav: UINavigationController?
  let paletteManager = PaletteManager.shared

  @IBOutlet weak var headline: UIStackView!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var saveAction: UIStackView!

  override func viewDidLoad() {
    super.viewDidLoad()
    cancelButton.applyShadow()
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(savePalette))
    saveAction.addGestureRecognizer(tapGesture)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    headline.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    headline.addBottomBorderWithColor(
      color: Constants.AppColors.dark,
      width: 1
    )
  }

  @objc func savePalette() {
    let alert = UIAlertController(
      title: "New Palette",
      message: "Enter a name for this palette.",
      preferredStyle: .alert
    )
    alert.addTextField { textField in
      textField.text = "My Palette"
    }
    let okAction = UIAlertAction(title: "Save", style: .default) { _ in
      self.paletteManager.add(
        name: alert.textFields![0].text!,
        backgroundHex: self.payload["background"]!,
        headlineHex: self.payload["headline"]!,
        bodyHex: self.payload["body"]!,
        buttonBgHex: self.payload["button"]!,
        buttonTextHex: self.payload["buttonText"]!
      )
      self.dismiss(animated: true) {
        self.nav?.popToRootViewController(animated: true)
      }
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
      alert.dismiss(animated: true)
    }

    alert.addAction(okAction)
    alert.addAction(cancelAction)

    self.present(alert, animated: true)
  }

  @IBAction func cancelAction(_ sender: Any) {
    self.dismiss(animated: true)
  }
}