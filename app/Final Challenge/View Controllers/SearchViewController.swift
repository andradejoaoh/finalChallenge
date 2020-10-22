//
//  SearchViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 22/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var ExpandableView: UIView!
    
    @IBOutlet weak var heightOfExpandableViewConstraint: NSLayoutConstraint!
    
    var expandableCategoryControl: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func expandCategoryButtonAction(_ sender: Any) {
        if expandableCategoryControl == false {
            heightOfExpandableViewConstraint.constant = 100.0
            self.view.setNeedsUpdateConstraints()
            expandableCategoryControl = true
        } else {
            heightOfExpandableViewConstraint.constant = 0.0
            self.view.setNeedsUpdateConstraints()
            expandableCategoryControl = false
        }
    }
}
