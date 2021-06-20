//
//  PalettePreviewViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 15/06/21.
//
//  swiftlint:disable type_body_length

import UIKit

class PalettePreviewViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var notion: UILabel!
  private var selectedColorsIndex = [Int]()
  private var selectedColorIndex = -1
  private var hasSelected = false
  private var popup: UIView?

  // MARK: - Step
  private var currentStep = 0 {
    didSet {
      clearHighlights()
      applyHighlights()
      hidePreviewElements()

      //      currentStepTitle.text = allSteps[currentStep].title
      title = allSteps[currentStep].title

      switch currentStep {
      case 4:
        previewButton.tintColor = UIColor(hex: "#222222")
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

    // Navigation Configuration
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "info.circle.fill"),
      style: .plain,
      target: self,
      action: #selector(infoButtonTapped)
    )

    // Testing Purpose:
    selectedCombination = ColorCombination
      .triadic
      .getCombination(from: UIColor(hex: "#52b69a"))

    setupView()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "seeFinalPreview" {
      if let finalPreviewViewController = segue.destination as? FinalPalettePreviewViewController,
         let finalPalette = sender as? [UIColor] {
        finalPreviewViewController.palette = finalPalette
      }
    }
  }

  // MARK: - Methods
  private func setupView() {
    // 1. Setup Current Step Title
    title = allSteps[currentStep].title

    // 2. Hide unused preview element for first step: Choose Background.
    hidePreviewElements()

    // 3. Apply styling
    [
      previewBackground,
      previewButton,
      backButton,
      nextButton
    ].forEach { element in
      element?.applyShadow()
      element?.layer.cornerRadius = 8
    }

    colorSet.forEach { element in
      element.applyShadow()
      element.layer.cornerRadius = 6
    }

    [
      backButton,
      nextButton
    ].forEach { button in
      button?.backgroundColor = UIColor(named: "Dark")
      button?.tintColor = UIColor(named: "Light")
    }

    // 4. Apply colors to color set
    ColorSet
      .generate(from: selectedCombination)
      .enumerated()
      .forEach { (index, color) in
        colorSet[index].backgroundColor = color
      }

    // 5. Add tap gesture to each color in color set
    colorSet.enumerated().forEach { (index, view) in
      view.tag = index
      let tapGesture = UITapGestureRecognizer(
        target: self,
        action: #selector(selectColor)
      )
      view.addGestureRecognizer(tapGesture)
    }
  }

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
      colorView.borderColor = Constants.AppColors.highlight.cgColor
      colorView.borderWidth = 4
    }
  }

  @objc func selectColor(_ sender: UITapGestureRecognizer) {
    hasSelected = true
    clearHighlights()
    applyHighlights()

    if let sender = sender.view,
       let selectedColor = sender.backgroundColor {
      switch currentStep {
      case 0:
        UIView.animate(withDuration: 0.75) {
          self.previewBackground.backgroundColor = selectedColor
        }
      case 1:
        UIView.animate(withDuration: 0.75) {
          self.previewTitle.textColor = selectedColor
        }
      case 2:
        UIView.animate(withDuration: 0.75) {
          self.previewBody.textColor = selectedColor
        }
      case 3:
        UIView.animate(withDuration: 0.75) {
          self.previewButton.backgroundColor = selectedColor
        }
      case 4:
        UIView.animate(withDuration: 0.75) {
          self.previewButton.tintColor = selectedColor
        }
      default:
        return
      }

      let selectedView = sender.layer
      selectedView.borderColor = Constants.AppColors.highlight.cgColor
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
      UIView.animate(withDuration: 0.75) {
        view.isUserInteractionEnabled = false
        view.layer.opacity = 0.1
      }
    }

    switch currentStep {
    // Reset for Background Color Step
    case 0:
      //      notion.isHidden = true
      colorSet.forEach { view in
        view.isUserInteractionEnabled = true
        view.layer.opacity = 1
      }
    // Curate for Headline Color Step
    case 1:
      //      notion.isHidden = false
      curatedColorsIndex = curateColorSet(baseColor: selectedBackgroundColor, for: .title)
    // Curate for Body Color Step
    case 2:
      curatedColorsIndex = curateColorSet(baseColor: selectedBackgroundColor, for: .body)
    // Curate for Button Color Step
    case 3:
      curatedColorsIndex = curateColorSet(baseColor: selectedBackgroundColor, for: .button)
    // Curate for Button Text Color Step
    case 4:
      if let selectedButtonColor = colorSet[selectedColorsIndex[3]].backgroundColor {
        curatedColorsIndex = curateColorSet(baseColor: selectedButtonColor, for: .body)
      }
    default:
      return
    }

    // Enable curated color(s) in Color Set
    curatedColorsIndex.forEach { index in
      UIView.animate(withDuration: 0.75) {
        self.colorSet[index].isUserInteractionEnabled = true
        self.colorSet[index].layer.opacity = 1
      }
    }
  }

  @objc func infoButtonTapped() {
    let step = allSteps[currentStep]
    if let popup = popup {
      UIView.animate(withDuration: 0.35) {
        popup.layer.opacity = 0
      } completion: { _ in
        popup.removeFromSuperview()
        self.popup = nil
      }
    } else {
      popup = popup(title: step.title, detail: step.detail) {
        self.popup = nil
      }
    }
  }

  @IBAction func previousStep(_ sender: Any) {
    if currentStep > 0 {
      currentStep -= 1
      updateColorSet()
      selectedColorsIndex.removeLast()
      hasSelected = true
      scrollUp()
    }
  }

  @IBAction func nextStep(_ sender: Any) {
    if hasSelected {
      if currentStep < 4 {
        // Update selected colors
        selectedColorsIndex.append(selectedColorIndex)
        currentStep += 1
        updateColorSet()
        scrollUp()
        hasSelected = false
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

        performSegue(withIdentifier: "seeFinalPreview", sender: finalPalette)
      }
    }
  }

}
