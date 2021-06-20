//
//  Extensions.swift
//  preferrd
//
//  Created by Christianto Budisaputra on 29/05/21.
//
// swiftlint:disable function_body_length

import Foundation
import UIKit

extension String {
  // Call on any string and it'll return a translated string, if any.
  /// ex: let hello = "Hello World".localized
  /// if any translation for "Hello World" is specified,
  /// then, based on the device's language, you'll get the translated string.
  var localized: String {
    NSLocalizedString(self, comment: "")
  }
}

// MARK: - UIView
extension UIView {
  func applyShadow() {
    self.layer.cornerRadius = 12
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOpacity = 0.125
    self.layer.shadowOffset = CGSize(width: 4, height: 4)
    self.layer.shadowRadius = 4
  }

  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(
      roundedRect: bounds,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }

  func addBottomBorder(color: UIColor = UIColor.red, margins: CGFloat = 0, borderLineSize: CGFloat = 1) {
    let border = UIView()
    border.layer.opacity = 0.05
    border.backgroundColor = color
    border.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(border)
    border.addConstraint(NSLayoutConstraint(
                          item: border,
                          attribute: .height,
                          relatedBy: .equal,
                          toItem: nil,
                          attribute: .height,
                          multiplier: 1, constant: borderLineSize))
    self.addConstraint(NSLayoutConstraint(
                        item: border,
                        attribute: .bottom,
                        relatedBy: .equal,
                        toItem: self,
                        attribute: .bottom,
                        multiplier: 1, constant: 0))
    self.addConstraint(NSLayoutConstraint(
                        item: border,
                        attribute: .leading,
                        relatedBy: .equal,
                        toItem: self,
                        attribute: .leading,
                        multiplier: 1, constant: margins))
    self.addConstraint(NSLayoutConstraint(
                        item: border,
                        attribute: .trailing,
                        relatedBy: .equal,
                        toItem: self,
                        attribute: .trailing,
                        multiplier: 1, constant: margins))
  }
}

extension UIViewController {
  func popup(title: String, detail: String, handler: @escaping () -> Void) -> UIView {
    // Setup popup window
    let popup = UIView()
    popup.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.7)
    popup.layer.opacity = 0
    popup.frame = self.view.bounds

    // Setup popup elements
    /// Title
    let titleLabel: UILabel = {
      let label = UILabel()
      label.text = title
      label.textColor = Constants.AppColors.dark
      label.font = UIFont.boldSystemFont(ofSize: 24)
      label.textAlignment = .center
      return label
    }()

    /// Text
    let detailLabel: UILabel = {
      let label = UILabel()
      label.text = detail
      label.textColor = Constants.AppColors.dark
      label.numberOfLines = 0
      label.textAlignment = .center
      return label
    }()

    /// Dismiss Button
    let okayAction = UIAction(handler: { _ in
      UIView.animate(withDuration: 0.35) {
        popup.layer.opacity = 0
      } completion: { _ in
        popup.removeFromSuperview()
        handler()
      }
    })

    let okayButton: UIButton = {
      let button = UIButton(primaryAction: okayAction)
      button.setTitle("Okay", for: .normal)
      button.setTitleColor(Constants.AppColors.light, for: .normal)
      button.backgroundColor = Constants.AppColors.dark
      button.applyShadow()
      let padding: CGFloat = 12
      button.contentEdgeInsets = UIEdgeInsets(
        top: padding,
        left: padding * 3,
        bottom: padding,
        right: padding * 3
      )
      return button
    }()

    // Setup container and Compile popup elements
    let container: UIStackView = {
      let view = UIStackView(arrangedSubviews: [titleLabel, detailLabel, okayButton])
      let padding: CGFloat = 24
      view.axis = .vertical
      view.spacing = 20
      view.alignment = .center
      view.backgroundColor = Constants.AppColors.container
      view.layer.cornerRadius = 20
      view.isLayoutMarginsRelativeArrangement = true
      view.translatesAutoresizingMaskIntoConstraints = false
      view.directionalLayoutMargins = NSDirectionalEdgeInsets(
        top: padding,
        leading: padding,
        bottom: padding,
        trailing: padding
      )
      return view
    }()

    // Apply constraints
    view.addSubview(popup)
    popup.addSubview(container)
    NSLayoutConstraint.activate([
      container.widthAnchor.constraint(equalTo: popup.widthAnchor, multiplier: 0.8),
      container.centerXAnchor.constraint(equalTo: popup.centerXAnchor),
      container.centerYAnchor.constraint(equalTo: popup.centerYAnchor)
    ])

    UIView.animate(withDuration: 0.35) {
      popup.layer.opacity = 1
    }

    return popup
  }
}

extension UIColor {

  // MARK: - Initialize UIColor from HEX Code
  convenience init(hex: String, alpha: CGFloat = 1.0) {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
      cString.remove(at: cString.startIndex)
    }

    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: alpha
    )
  }

  var hex: String {
    guard let components = self.cgColor.components else { fatalError("HEX: Error Getting Color Components.") }
    let red: CGFloat = components[0]
    let green: CGFloat = components[1]
    let blue: CGFloat = components[2]

    let hexString = String.init(
      format: "#%02lX%02lX%02lX",
      lroundf(Float(red * 255)),
      lroundf(Float(green * 255)),
      lroundf(Float(blue * 255))
    )
    return hexString
  }

  // MARK: - Color Combination Extensions
  func complement() -> UIColor {
    withHue(adjustedBy: 0.5)
  }

  func withHue(adjustedBy change: CGFloat) -> UIColor {

    guard (-1.0...1.0).contains(change) else {
      fatalError("Hue adjustment must be between 1.0 and -1.0")
    }

    var hue: CGFloat         = 0
    var saturation: CGFloat  = 0
    var brightness: CGFloat  = 0
    var alpha: CGFloat       = 0

    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    return UIColor(hue: fmod(hue + change, 1),
                   saturation: saturation,
                   brightness: brightness,
                   alpha: alpha)
  }

  func withSaturation(adjustedBy change: CGFloat,
                      floorAt floor: CGFloat = 0.0,
                      ceilingAt ceiling: CGFloat = 1.0,
                      withOverflow: Bool = false) -> UIColor {

    var hue: CGFloat         = 0
    var saturation: CGFloat  = 0
    var brightness: CGFloat  = 0
    var alpha: CGFloat       = 0

    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    var newSaturation = saturation + change

    if withOverflow {
      if newSaturation > ceiling {
        newSaturation -= ceiling-floor
      } else if newSaturation < floor {
        newSaturation += ceiling-floor
      }
    } else {
      if newSaturation > ceiling {
        newSaturation = ceiling
      } else if newSaturation < floor {
        newSaturation = floor
      }
    }

    return UIColor(hue: hue,
                   saturation: newSaturation,
                   brightness: brightness,
                   alpha: alpha)
  }

  func withBrightness(adjustedBy change: CGFloat,
                      floorAt floor: CGFloat = 0.0,
                      ceilingAt ceiling: CGFloat = 1.0,
                      withOverflow: Bool = false) -> UIColor {

    var hue: CGFloat         = 0
    var saturation: CGFloat  = 0
    var brightness: CGFloat  = 0
    var alpha: CGFloat       = 0

    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    var newBrightness = brightness + change

    if withOverflow {
      if newBrightness > ceiling {
        newBrightness -= ceiling-floor
      } else if newBrightness < floor {
        newBrightness += ceiling-floor
      }
    } else {
      if newBrightness > ceiling {
        newBrightness = ceiling
      } else if newBrightness < floor {
        newBrightness = floor
      }
    }

    return UIColor(hue: hue,
                   saturation: saturation,
                   brightness: newBrightness,
                   alpha: alpha)
  }

}

extension Array where Element == UIView? {
  func hide() {
    self.forEach { $0?.layer.opacity = 0 }
  }
}
