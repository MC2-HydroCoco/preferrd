//
//  FinalPalettePreviewViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 16/06/21.
//

import UIKit

class FinalPalettePreviewViewController: UIViewController {
  // CoreData Helper
  let paletteManager = PaletteManager.shared

  // Required Payload
  var palette: [UIColor] = [.red, .blue, .brown, .cyan, .yellow]
  var paletteToUpdate: Palette?

  // Palette Preview Properties
  @IBOutlet weak var previewBackground: UIStackView!
  @IBOutlet weak var previewTitle: UILabel!
  @IBOutlet weak var previewBody: UILabel!
  @IBOutlet weak var previewButton: UIButton!

  // Color Palette Properties
  @IBOutlet var colorPalette: [UIView]!
  @IBOutlet var colorPaletteHex: [UILabel]!

  // Adjustment Properties Label
  @IBOutlet weak var backgroundLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  @IBOutlet weak var buttonLabel: UILabel!
  @IBOutlet weak var buttonTextLabel: UILabel!

  // Adjustment Properties
  var selectedColorIndex = 0
  var initialPalette = [UIColor]()
  @IBOutlet weak var adjustmentTitle: UILabel!
  @IBOutlet weak var saturationLabel: UILabel!
  @IBOutlet weak var brightnessLabel: UILabel!
  @IBOutlet weak var saturationSlider: UISlider!
  @IBOutlet weak var brightnessSlider: UISlider!
  @IBOutlet weak var saturationWarning: UIButton!
  @IBOutlet weak var brightnessWarning: UIButton!
  @IBOutlet weak var adjustmentPanel: UIStackView!
  @IBOutlet weak var applyButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "seeActionSheet" {
      if let destination = segue.destination as? PaletteActionViewController,
         let payload = sender as? [String: String] {
        destination.payload = payload
        destination.nav = navigationController
      }
    }
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

    // Apply Styling
    ([
      previewBackground,
      previewButton,
      applyButton
    ] + colorPalette).forEach { view in
      view?.applyShadow()
    }

    // Add tap gesture to each color in color palette
    colorPalette.enumerated().forEach { (index, view) in
      view.tag = index
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectColor))
      view.addGestureRecognizer(tapGesture)
    }

    // Localize
    title = "final_preview.title".localized
    previewTitle.text = PreviewComponents.title.locale
    previewBody.text = PreviewComponents.text.locale
    previewButton.setTitle(PreviewComponents.button.locale, for: .normal)

    backgroundLabel.text  = "final_preview.color.background".localized
    titleLabel.text       = "final_preview.color.title".localized
    bodyLabel.text        = "final_preview.color.body".localized
    buttonLabel.text      = "final_preview.color.button".localized
    buttonTextLabel.text  = "final_preview.color.button_txt".localized

    applyButton.setTitle(
      "final_preview.adjustment.apply".localized,
      for: .normal
    )
    saturationLabel.text = "final_preview.adjustment.saturation".localized
    brightnessLabel.text = "final_preview.adjustment.brightness".localized
    adjustmentTitle.text = "final_preview.adjustment.title".localized
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
      resetHighligths()
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
      colorPaletteHex[selectedColorIndex].text = initialColor.hex

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

  @IBAction func discardChanges(_ sender: Any) {
    resetPalette()
    updateSlidersValue()
  }

  @IBAction func applyChanges(_ sender: Any) {
    self.adjustmentPanel.isHidden = true
    updateHighlight()
  }

  private func resetHighligths(handler: (() -> Void)? = nil) {
    // Reset Highlight
    colorPalette.forEach { view in
      view.layer.borderWidth = 4
      view.layer.borderColor = UIColor.clear.cgColor
    }
  }

  private func updateHighlight() {
    if self.adjustmentPanel.isHidden == false {
      colorPalette[self.selectedColorIndex].layer.borderColor = Constants.AppColors.highlight.cgColor
    }
  }

  @IBAction func toggleAdjustment(_ sender: Any) {
    if adjustmentPanel.isHidden {
      adjustmentPanel.layer.opacity = 0
      self.adjustmentPanel.isHidden.toggle()
      UIView.animate(withDuration: 0.35) {
        self.adjustmentPanel.layer.opacity = 1
      }
      resetPalette()
      resetHighligths()
      updateHighlight()
      adjustColor()
    } else {
      resetHighligths()
      UIView.animate(withDuration: 0.35) {
        self.adjustmentPanel.layer.opacity = 0
      } completion: { _ in
        self.adjustmentPanel.isHidden.toggle()
      }
    }
  }

  @objc func doneButtonTapped() {
    if let background = previewBackground.backgroundColor,
       let title      = previewTitle.textColor,
       let body       = previewBody.textColor,
       let button     = previewButton.backgroundColor,
       let buttonText = previewButton.tintColor {

      if let paletteToUpdate = paletteToUpdate {
        paletteManager.update(
          palette: paletteToUpdate,
          name: "My Palette",
          backgroundHex: background.hex,
          headlineHex: title.hex,
          bodyHex: body.hex,
          buttonBgHex: button.hex,
          buttonTextHex: buttonText.hex
        )
        navigationController?.popToRootViewController(animated: true)
      } else {
        let payload = [
          "background": background.hex,
          "headline": title.hex,
          "body": body.hex,
          "button": button.hex,
          "buttonText": buttonText.hex
        ]
        performSegue(withIdentifier: "seeActionSheet", sender: payload)
      }
    }
  }
}
