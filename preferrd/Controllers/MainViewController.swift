//
//  ViewController.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 28/05/21.
// swiftlint:disable force_cast

import UIKit
import CoreData

class MainViewController: UIViewController {

  @IBOutlet weak var paletteTableView: UITableView!

  var prevCell: PaletteTableViewCell?
  var currCell: PaletteTableViewCell?

  let textLayer: CATextLayer = {
    let textLayer = CATextLayer()
    textLayer.alignmentMode = .center
    textLayer.fontSize = 17
    textLayer.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    textLayer.string = "Remove"
    textLayer.foregroundColor = UIColor.white.cgColor
    textLayer.contentsScale = UIScreen.main.scale
    textLayer.frame = CGRect(x: 0, y: 26, width: 96, height: 72)
    return textLayer
  }()
  var removeAction: CALayer = {
    let layer = CALayer()
    layer.cornerRadius = 12
    layer.backgroundColor = UIColor.systemRed.cgColor
    return layer
  }()

  var palettes: [Palette] = [] {
    didSet {
      paletteTableView.reloadData()
    }
  }
  let paletteManager = PaletteManager()

  override func viewDidLoad() {
    super.viewDidLoad()

    paletteTableView.delegate = self
    paletteTableView.dataSource = self

    let nibCell = UINib(nibName: "\(PaletteTableViewCell.self)", bundle: nil)
    paletteTableView.register(nibCell, forCellReuseIdentifier: "paletteTableViewCell")

    setupRemoveAction()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

//    paletteManager.add(
//    name: "Sample Palette",
//    backgroundHex: "#FFFFFF",
//    headlineHex: "#212121",
//    bodyHex: "#303030",
//    buttonBgHex: "#121212",
//    buttonTextHex: "#FFFFFF"
//    )
    palettes = paletteManager.fetch()
  }

  func setupRemoveAction() {
    removeAction.addSublayer(textLayer)

    removeAction.opacity = 0
  }

  // MARK: - Prepare
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "editPalette" {
      if let destination = segue.destination as? FinalPalettePreviewViewController,
         let payload = sender as? Palette {
        destination.paletteToUpdate = payload
        destination.palette = [
          UIColor(hex: payload.backgroundHex!),
          UIColor(hex: payload.headlineHex!),
          UIColor(hex: payload.bodyHex!),
          UIColor(hex: payload.buttonBgHex!),
          UIColor(hex: payload.buttonTextHex!)
        ]
      }
    }
  }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return palettes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "paletteTableViewCell") as! PaletteTableViewCell

    let palette = palettes[indexPath.row]

    cell.nameLabel.text = palette.name
    cell.backgroundColorView.backgroundColor = UIColor(hex: palette.backgroundHex!)
    cell.headlineColorView.backgroundColor = UIColor(hex: palette.headlineHex!)
    cell.bodyColorView.backgroundColor = UIColor(hex: palette.bodyHex!)
    cell.buttonBgView.backgroundColor = UIColor(hex: palette.buttonBgHex!)
    cell.buttonTextView.backgroundColor = UIColor(hex: palette.buttonTextHex!)

    let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
    gestureRecognizer.delegate = self
    cell.addGestureRecognizer(gestureRecognizer)

    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    cell.addGestureRecognizer(tapRecognizer)

    return cell
  }

  @objc func handleGesture(_ sender: UIPanGestureRecognizer) {
    let location = sender.location(in: paletteTableView)
    let translation = sender.translation(in: view)

    if let indexPath = paletteTableView.indexPathForRow(at: location) {
      guard let cell = paletteTableView.cellForRow(at: indexPath) as? PaletteTableViewCell else { return }

      switch sender.state {
      case .began:
        if let prevCell = prevCell, cell != prevCell {
          UIView.animate(withDuration: 0.3) {
            prevCell.contentView.frame.origin.x = 0
          }
        }
        currCell = cell
        removeAction.frame = CGRect(x: cell.contentView.frame.width, y: 0, width: 96, height: 72)
      case .changed:
        if translation.y > -6 && translation.y < 6 {
          cell.contentView.center = CGPoint(x: cell.contentView.center.x + translation.x, y: cell.contentView.center.y)
          sender.setTranslation(.zero, in: view)

          removeAction.opacity = 0

          if translation.x < -4 {
            cell.layer.insertSublayer(removeAction, at: 0)

            UIView.animate(withDuration: 0.3) {
              self.removeAction.opacity = 1
              cell.contentView.frame.origin.x = -108
              self.removeAction.frame.origin.x = cell.contentView.frame.width - 120
            }
          } else {
            UIView.animate(withDuration: 0.3) {
              cell.contentView.frame.origin.x = 0
            }
          }
        }
      case .ended:
        self.prevCell = cell
      default:
        break
      }
    }
  }

  @objc func handleTap(_ sender: UITapGestureRecognizer) {
    let location = sender.location(in: currCell)
    if let currCell = currCell {
      if removeAction.frame.contains(location) {
        if let index = paletteTableView.indexPath(for: currCell) {
          removeAction.removeFromSuperlayer()
          DispatchQueue.main.async {
            //                        self.paletteTableView.deleteRows(at: [index], with: .right)
          }
          paletteManager.remove(palette: palettes[index.row])
          palettes = paletteManager.fetch()
        }
      }
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "editPalette", sender: palettes[indexPath.row])
  }
}

extension MainViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
      let translation = panGestureRecognizer.translation(in: paletteTableView)
      if abs(translation.x) > abs(translation.y) {
        return true
      }
    }

    return false
  }
}
