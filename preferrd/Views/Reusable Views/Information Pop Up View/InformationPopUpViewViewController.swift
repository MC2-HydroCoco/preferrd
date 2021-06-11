//
//  InformationPopUpViewViewController.swift
//  preferrd
//
//  Created by Michelle Linus on 11/06/21.
//

import UIKit

class InformationPopUpViewViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var paragraph: UILabel!
    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var popUpBackground: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        okayButton.layer.cornerRadius = 12
    }

    @IBAction func okayButtonPressed(_ sender: UIButton) {
    }
    
    

}
