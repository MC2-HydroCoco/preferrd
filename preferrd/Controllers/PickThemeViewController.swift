//
//  PickThemeViewController.swift
//  preferrd
//
//  Created by Antonio Mario on 11/06/21.
//
// swiftlint:disable force_cast

import UIKit

class PickThemeViewController: UIViewController {
    
    @IBOutlet weak var themeCollectionView: UICollectionView!
    
    @IBOutlet var themeSet: [ThemeView]!
    
    var selectedThemes = [ColorTheme]() {
        didSet {
            themeCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextTapped))
        
        let nibCell = UINib(nibName: "\(ThemeCollectionViewCell.self)", bundle: nil)
        themeCollectionView.register(nibCell, forCellWithReuseIdentifier: "themeCollectionViewCell")
        
        themeCollectionView.delegate = self
        themeCollectionView.dataSource = self
        themeCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        themeCollectionView.allowsMultipleSelection = true
        
        setupThemeSet()
    }
    
    @objc func nextTapped() {
        performSegue(withIdentifier: "pickBaseColor", sender: self)
    }
    
    func setupThemeSet() {
        themeSet.enumerated().forEach{ (index, view) in
            view.tag = index
            
            // Set style
            view.roundCorners(corners: .allCorners, radius: 12)
            
            // Set tap gesture
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectTheme))
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func selectTheme(_ sender: UITapGestureRecognizer) {
        if let senderView = sender.view as? ThemeView {
            senderView.toggleSelect()
            if senderView.isSelected {
                selectedThemes.append(ColorTheme.allCases[senderView.tag])
            } else {
                selectedThemes.removeAll(where: {ColorTheme.allCases[senderView.tag] == $0})
            }
        }
    }
    
    // MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickBaseColor" {
            if let destination = segue.destination as? PickBaseColorViewController {
                destination.themes = selectedThemes
            }
        }
    }
}

extension PickThemeViewController: UICollectionViewDataSource, UICollectionViewDelegate,
                                   UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedThemes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "themeCollectionViewCell",
            for: indexPath) as? ThemeCollectionViewCell {
            
            cell.themeContainer.layer.cornerRadius = 12
            cell.themeLabel.text = selectedThemes[indexPath.row].rawValue
            cell.imageContainer.isHidden = true
            cell.removeButton.isHidden = true
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            cell.addGestureRecognizer(tapRecognizer)
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let item = selectedThemes[indexPath.row].rawValue
        let itemSize = item.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32)
        ])
        return itemSize
    }
    
    @objc func handleTap (_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: themeCollectionView)
        if let indexPath = themeCollectionView.indexPathForItem(at: location) {
            for view in themeSet {
                if selectedThemes[indexPath.row].rawValue == view.themeLabel.text {
                    view.toggleSelect()
                    break
                }
            }
            
            selectedThemes.remove(at: indexPath.row)
        }
    }
}
