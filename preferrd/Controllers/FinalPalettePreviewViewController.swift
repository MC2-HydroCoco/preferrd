//
//  FinalPalettePreviewViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 16/06/21.
//

import UIKit

class FinalPalettePreviewViewController: UIViewController {
  // Required Payload
  var palette = [UIColor]()

  // Palette Preview Properties
  @IBOutlet weak var previewBackground: UIStackView!
  @IBOutlet weak var previewTitle: UILabel!
  @IBOutlet weak var previewBody: UILabel!
  @IBOutlet weak var previewButton: UIButton!

  // Color Palette Properties
  @IBOutlet var colorPalette: [UIView]!
  @IBOutlet var colorPaletteHex: [UILabel]!

  // Adjustment Properties
  var selectedColorIndex = 0
  @IBOutlet weak var saturationSlider: UISlider!
  @IBOutlet weak var brightnessSlider: UISlider!
  @IBOutlet weak var saturationWarning: UIButton!
  @IBOutlet weak var brightnessWarning: UIButton!
  @IBOutlet weak var adjustmentPanel: UIStackView!
  @IBOutlet weak var discardButton: UIButton!
  @IBOutlet weak var applyButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

  private func setupView() {
    // Navigation Bar Item
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(doneButtonTapped)
    )

    // Palette Related Setup
    palette.enumerated().forEach { (index, color) in
      colorPalette[index].backgroundColor = color
      colorPaletteHex[index].text = color.hex
      switch index {
      case 0:
        previewBackground.backgroundColor = color
      case 1:
        previewTitle.textColor = color
      case 2:
        previewBody.textColor = color
      case 3:
        previewButton.backgroundColor = color
      case 4:
        previewButton.tintColor = color
      default:
        return
      }
    }

    // Adjustment Sliders Setup
    saturationSlider.addTarget(
      self,
      action: #selector(adjustColor),
      for: .valueChanged
    )
    brightnessSlider.addTarget(
      self,
      action: #selector(adjustColor),
      for: .valueChanged
    )

    if let initialColor = colorPalette[selectedColorIndex].backgroundColor {
      saturationSlider.value = initialColor.getSaturation()
      brightnessSlider.value = initialColor.getBrightness()
    }

    // Apply Design
    ([
      previewBackground,
      previewButton,
      discardButton,
      applyButton
    ] + colorPalette).forEach { view in
      view?.layer.cornerRadius = 8
    }
  }

  @objc func adjustColor() {
    if let initialColor = colorPalette[selectedColorIndex].backgroundColor {
      colorPalette[selectedColorIndex].backgroundColor = initialColor.modify(
        saturation: saturationSlider.value,
        brightness: brightnessSlider.value
      )
    }
  }

  @objc func doneButtonTapped() {
    print("Perform Segue!")
  }

  @IBAction func toggleAdjustment(_ sender: Any) {
    self.adjustmentPanel.isHidden.toggle()
    adjustColor()
  }
}
