//
//  PalettePreviewViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 15/06/21.
//

import UIKit

class PalettePreviewViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!
  private var selectedColorsIndex = [Int]()
  private var selectedColorIndex = 0

  // MARK: - Step
  private var currentStep = 0 {
    didSet {
      clearHighlights()
      applyHighlights()
      hidePreviewElements()

      currentStepTitle.text = allSteps[currentStep].title

      switch currentStep {
      case 4:
        previewButton.tintColor = .black
        fallthrough
      case 3:
        previewButton.layer.opacity = 1
        fallthrough
      case 2:
        previewBody.layer.opacity = 1
        fallthrough
      case 1:
        previewTitle.layer.opacity = 1
        fallthrough
      case 0:
        previewBackground.layer.opacity = 1
      default:
        return
      }
    }
  }
  private let allSteps = PreviewStep.allCases
  @IBOutlet weak var currentStepTitle: UILabel!
  @IBOutlet weak var currentStepDetail: UIButton!

  // MARK: - Preview Components
  @IBOutlet weak var previewBackground: UIStackView!
  @IBOutlet weak var previewTitle: UILabel!
  @IBOutlet weak var previewBody: UILabel!
  @IBOutlet weak var previewButton: UIButton!
  private var allPreviewComponents = [UIView]()

  // MARK: - Color Set
  var selectedCombination = [UIColor]()
  @IBOutlet var colorSet: [UIView]!

  // MARK: - Overrides
  override func viewDidLoad() {
    super.viewDidLoad()

    // Testing Purpose:
    selectedCombination = ColorCombination
      .accentedAnalogous
      .getCombination(from: UIColor(hex: "#BADA55"))

    setupView()

  }

  private func setupView() {
    // 1. Hide unused preview element for first step: Choose Background.
    hidePreviewElements()

    // 2. Apply styling
    ([
      previewBackground,
      previewButton,
      backButton,
      nextButton
    ] + colorSet).forEach { element in
      element?.layer.cornerRadius = 8
    }

    // 3. Apply colors to color set
    ColorSet
      .generate(from: selectedCombination)
      .enumerated()
      .forEach { (index, color) in
        colorSet[index].backgroundColor = color
      }

    // 4. Add tap gesture to each color in color set
    colorSet.enumerated().forEach { (index, view) in
      view.tag = index
      let tapGesture = UITapGestureRecognizer(
        target: self,
        action: #selector(selectColor)
      )
      view.addGestureRecognizer(tapGesture)
    }
  }

  // MARK: - Methods

  private func hidePreviewElements() {
    [
      previewTitle,
      previewBody,
      previewButton
    ].hide()
    previewButton.tintColor = .clear
  }

  private func scrollUp() {
    scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
  }

  private func clearHighlights() {
    colorSet.forEach { view in
      view.layer.borderWidth = 0
    }
  }

  private func applyHighlights() {
    selectedColorsIndex.forEach { index in
      let colorView = colorSet[index].layer
      colorView.borderColor = UIColor.black.cgColor
      colorView.borderWidth = 4
    }
  }

  @objc func selectColor(_ sender: UITapGestureRecognizer) {
    clearHighlights()
    applyHighlights()

    if let sender = sender.view,
       let selectedColor = sender.backgroundColor {
      switch currentStep {
      case 0:
        previewBackground.backgroundColor = selectedColor
      case 1:
        previewTitle.textColor = selectedColor
      case 2:
        previewBody.textColor = selectedColor
      case 3:
        previewButton.backgroundColor = selectedColor
      case 4:
        previewButton.tintColor = selectedColor
      default:
        return
      }

      let selectedView = sender.layer
      selectedView.borderColor = UIColor.black.cgColor
      selectedView.borderWidth = 4

      selectedColorIndex = sender.tag
    }
  }

  private func curateColorSet(baseColor: UIColor, for type: ContrastRatioType) -> [Int] {
    let initialColors = colorSet.map { $0.backgroundColor! }

    return ColorSet.filterContrastRatio(
      baseColor: baseColor,
      from: initialColors,
      for: type
    )
  }

  private func updateColorSet() {
    var curatedColorsIndex = [Int]()
    let selectedBackgroundColor = colorSet[selectedColorsIndex[0]].backgroundColor!

    // Disable all colors in Color Set
    colorSet.forEach { view in
      view.isUserInteractionEnabled = false
      view.layer.opacity = 0.1
    }

    switch currentStep {
    // Reset for Background Color Step
    case 0:
      print("0")
      colorSet.forEach { view in
        view.isUserInteractionEnabled = true
        view.layer.opacity = 1
      }
    // Curate for Headline Color Step
    case 1:
      print("1")
      curatedColorsIndex = curateColorSet(baseColor: selectedBackgroundColor, for: .title)
    // Curate for Body Color Step
    case 2:
      print("2")
      curatedColorsIndex = curateColorSet(baseColor: selectedBackgroundColor, for: .body)
    // Curate for Button Color Step
    case 3:
      print("3")
      curatedColorsIndex = curateColorSet(baseColor: selectedBackgroundColor, for: .button)
    // Curate for Button Text Color Step
    case 4:
      print("4")
      let selectedButtonColor = colorSet[selectedColorsIndex[3]].backgroundColor!
      curatedColorsIndex = curateColorSet(baseColor: selectedButtonColor, for: .body)
    default:
      return
    }

    // Enable curated color(s) in Color Set
    curatedColorsIndex.forEach { index in
      colorSet[index].isUserInteractionEnabled = true
      colorSet[index].layer.opacity = 1
    }
  }

  @IBAction func previousStep(_ sender: Any) {
    if currentStep > 0 {
      currentStep -= 1
      updateColorSet()
      selectedColorsIndex.removeLast()
      scrollUp()
    }
  }

  @IBAction func nextStep(_ sender: Any) {
    if currentStep < 4 {
      // Update selected colors
      selectedColorsIndex.append(selectedColorIndex)
      currentStep += 1
      updateColorSet()
      scrollUp()
    } else {
      guard let background = previewBackground.backgroundColor,
            let title = previewTitle.textColor,
            let body = previewBody.textColor,
            let button = previewButton.backgroundColor,
            let buttonText = previewButton.tintColor else {
        fatalError("Error getting Preview Element's color")
      }

      let finalPalette = [
        background,
        title,
        body,
        button,
        buttonText
      ]

      print(finalPalette)
      print("Perform Segue!")
    }
  }

}
