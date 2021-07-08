//
//  PickThemeViewController.swift
//  preferrd
//
//  Created by Antonio Mario on 11/06/21.
//

import UIKit

class PickThemeViewController: UIViewController {
  @IBOutlet weak var themeCollectionView: UICollectionView!

  @IBOutlet var themeSet: [ThemeView]!

  // Themes Label
  @IBOutlet weak var relaxingLabel: UILabel!
  @IBOutlet weak var vintageLabel: UILabel!
  @IBOutlet weak var playfulLabel: UILabel!
  @IBOutlet weak var adventurousLabel: UILabel!
  @IBOutlet weak var modernLabel: UILabel!
  @IBOutlet weak var natureLabel: UILabel!
  @IBOutlet weak var freshLabel: UILabel!
  @IBOutlet weak var elegantLabel: UILabel!
  @IBOutlet weak var feminineLabel: UILabel!
  @IBOutlet weak var masculineLabel: UILabel!

  var selectedThemes = [ColorTheme]() {
    didSet {
      themeCollectionView.reloadData()
      toggleNextButton()
    }
  }
  var selectMaxed: Bool = false

  let colorManager = ColorManager.shared

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "theme.title".localized

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "nav.next".localized,
      style: .done,
      target: self,
      action: #selector(nextTapped)
    )

    setupThemeCollectionView()
    setupThemeSet()
    toggleNextButton()
  }

  private func toggleNextButton() {
    if selectedThemes.count < 1 {
      navigationItem.rightBarButtonItem?.isEnabled = false
    } else {
      navigationItem.rightBarButtonItem?.isEnabled = true
    }
  }

  @objc func nextTapped() {
    performSegue(withIdentifier: "pickBaseColor", sender: self)
  }

  func setupThemeCollectionView() {
    let nibCell = UINib(nibName: "\(ThemeCollectionViewCell.self)", bundle: nil)
    themeCollectionView.register(nibCell, forCellWithReuseIdentifier: "themeCollectionViewCell")

    themeCollectionView.delegate = self
    themeCollectionView.dataSource = self
  }

  func setupThemeSet() {
    themeSet.enumerated().forEach { (index, view) in
      view.tag = index

      // Set style
      view.layer.cornerRadius = 12
      view.themeImageView.alpha = 0.6

      // Set tap gesture
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectTheme))
      view.addGestureRecognizer(tapGesture)
    }

    // Localize Labels
    relaxingLabel.text    = ColorTheme.relaxing.locale
    vintageLabel.text     = ColorTheme.vintage.locale
    playfulLabel.text     = ColorTheme.playful.locale
    adventurousLabel.text = ColorTheme.adventurous.locale
    natureLabel.text      = ColorTheme.nature.locale
    modernLabel.text      = ColorTheme.modern.locale
    freshLabel.text       = ColorTheme.fresh.locale
    elegantLabel.text     = ColorTheme.elegant.locale
    feminineLabel.text    = ColorTheme.feminine.locale
    masculineLabel.text   = ColorTheme.masculine.locale
  }

  @objc func selectTheme(_ sender: UITapGestureRecognizer) {
    if let senderView = sender.view as? ThemeView {
      if selectMaxed && !senderView.isSelected {
        return
      }

      senderView.toggleSelect()

      if senderView.isSelected {
        selectedThemes.append(ColorTheme.allCases[senderView.tag])
        if selectedThemes.count > 2 {
          selectMaxed = true
          disableAll()
        }
      } else {
        selectedThemes.removeAll(where: {ColorTheme.allCases[senderView.tag] == $0})
        selectMaxed = false
        enableAll()
      }
    }
  }

  func disableAll() {
    for view in themeSet where view.isSelected == false {
      view.themeImageView.alpha = 0.2
    }
  }

  func enableAll() {
    for view in themeSet where view.isSelected == false {
      view.themeImageView.alpha = 0.6
    }
  }

  // MARK: - Prepare
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "pickBaseColor" {
      if let destination = segue.destination as? PickBaseColorViewController {
        destination.themes = selectedThemes
        destination.relatedColors = colorManager.getRelatedColors(themes: selectedThemes)
      }
    }
  }
}

extension PickThemeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return selectedThemes.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "themeCollectionViewCell",
        for: indexPath) as? ThemeCollectionViewCell {

      cell.themeLabel.text = selectedThemes[indexPath.row].locale
      cell.imageContainer.isHidden = true
      cell.removeButton.isHidden = true

      let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
      cell.addGestureRecognizer(tapRecognizer)
      return cell
    }
    return UICollectionViewCell()
  }

  @objc func handleTap (_ sender: UITapGestureRecognizer) {
    let location = sender.location(in: themeCollectionView)
    if let indexPath = themeCollectionView.indexPathForItem(at: location) {
      for view in themeSet where selectedThemes[indexPath.row].rawValue == view.themeLabel.text {
        view.toggleSelect()
        break
      }

      selectedThemes.remove(at: indexPath.row)
      selectMaxed = false
      enableAll()
    }
  }
}
