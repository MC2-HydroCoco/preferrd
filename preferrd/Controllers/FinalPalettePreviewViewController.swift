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
  var initialPalette = [UIColor]()
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

  private func resetPalette() {
    previewBackground.backgroundColor = palette[0]
    previewTitle.textColor = palette[1]
    previewBody.textColor = palette[2]
    previewButton.backgroundColor = palette[3]
    previewButton.tintColor = palette[4]

    palette.enumerated().forEach { (index, color) in
      colorPalette[index].backgroundColor = color
      colorPaletteHex[index].text = color.hex
    }
  }

  private func setupView() {
    // Navigation Bar Item
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(doneButtonTapped)
    )

    // Palette Related Setup
    resetPalette()

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

    updateSlidersValue()

    // Apply Design
    ([
      previewBackground,
      previewButton,
      discardButton,
      applyButton
    ] + colorPalette).forEach { view in
      view?.layer.cornerRadius = 8
    }

    // Add tap gesture to each color in color palette
    colorPalette.enumerated().forEach { (index, view) in
      view.tag = index
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectColor))
      view.addGestureRecognizer(tapGesture)
    }
  }

  private func updateSlidersValue() {
    if let color = colorPalette[selectedColorIndex].backgroundColor {
        saturationSlider.value = color.getSaturation()
        brightnessSlider.value = color.getBrightness()
    }
  }

  @objc func selectColor(_ sender: UITapGestureRecognizer) {
    if let sender = sender.view {
      selectedColorIndex = sender.tag
      updateHighlight()
      updateSlidersValue()
    }
  }

  @objc func adjustColor() {
    if let initialColor = colorPalette[selectedColorIndex].backgroundColor {
      colorPalette[selectedColorIndex].backgroundColor = initialColor.modify(
        saturation: saturationSlider.value,
        brightness: brightnessSlider.value
      )
      switch selectedColorIndex {
      case 0:
        previewBackground.backgroundColor = initialColor
      case 1:
        previewTitle.textColor = initialColor
      case 2:
        previewBody.textColor = initialColor
      case 3:
        previewButton.backgroundColor = initialColor
      case 4:
        previewButton.tintColor = initialColor
      default:
        return
      }
    }
  }

  @objc func doneButtonTapped() {
    print("Perform Segue!")
  }

  @IBAction func discardChanges(_ sender: Any) {
    resetPalette()
    updateSlidersValue()
  }

  @IBAction func applyChanges(_ sender: Any) {
    self.adjustmentPanel.isHidden = true
    updateHighlight()
  }

  private func updateHighlight() {
    // Reset Highlight
    colorPalette.forEach { view in
      view.layer.borderWidth = 4
      view.layer.borderColor = UIColor.clear.cgColor
    }

    // Apply new highlight
    if adjustmentPanel.isHidden == false {
      colorPalette[selectedColorIndex].layer.borderColor = Constants.AppColors.highlight?.cgColor
    }
  }

  @IBAction func toggleAdjustment(_ sender: Any) {
    self.adjustmentPanel.isHidden.toggle()
    adjustColor()
    updateHighlight()
  }
}
