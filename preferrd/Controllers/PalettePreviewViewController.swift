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

  // MARK: - Step
  private var currentStep = 0
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
  var selectedCombination = [UIColor]() {
    didSet {
      generatedColorSet = ColorSet.from(selectedCombination)
    }
  }
  private var generatedColorSet = [UIColor]() {
    didSet {
      // Apply color to each background of color view.
      generatedColorSet.enumerated().forEach { (index, color) in
        colorSet[index].backgroundColor = color
      }
    }
  }
  @IBOutlet var colorSet: [UIView]!

  // MARK: - Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPreviewComponents()
    resetPreview()
    addTapGesturesToColorSet()
    updatePreview()
    applyDesign()

    selectedCombination = ColorCombination(rawValue: "Analogous")!.getCombination(from: UIColor(hex: "#BADA55"))
  }

  // MARK: - Methods
  private func applyDesign() {
    ([previewBackground, previewButton]+colorSet).forEach { view in
      view.layer.cornerRadius = 8
    }
  }

  private func setupPreviewComponents() {
    allPreviewComponents.append(contentsOf: [
      previewBackground,
      previewTitle,
      previewBody,
      previewButton
    ])
  }

  private func resetPreview() {
    // 🧹 Hide Components
    allPreviewComponents.forEach { component in
      component.layer.opacity = 0
      if component == previewButton {
        component.tintColor = .clear
      }
    }
  }

  private func addTapGesturesToColorSet() {
    colorSet.enumerated().forEach { (index, color) in
      color.tag = index
      let tapGesture = UITapGestureRecognizer(
        target: self,
        action: #selector(selectColor)
      )
      color.addGestureRecognizer(tapGesture)
    }
  }

  @objc func selectColor(_ sender: UITapGestureRecognizer) {
    let selectedColor = sender.view?.backgroundColor
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
  }

  private func updatePreview() {
    let step = allSteps[currentStep]
    currentStepTitle.text = step.title
    (0...currentStep).forEach { step in
      if step == 4 {
        previewButton.tintColor = .label
      } else {
        allPreviewComponents[step].layer.opacity = 1
      }
    }
  }

  private func scrollUp() {
    scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
  }

  @IBAction func previousStep(_ sender: Any) {
    if currentStep > 0 {
      resetPreview()
      scrollUp()
      currentStep -= 1
      updatePreview()
    }
  }

  @IBAction func nextStep(_ sender: Any) {
    if currentStep < 4 {
      scrollUp()
      currentStep += 1
      updatePreview()
    } else {
      // Perform Segue
      print("Perform Segue!")
      let finalPalette = [
        previewBackground.backgroundColor!,
        previewTitle.textColor!,
        previewBody.textColor!,
        previewButton.backgroundColor!,
        previewButton.tintColor!
      ]
      print(finalPalette)
    }
  }

}
