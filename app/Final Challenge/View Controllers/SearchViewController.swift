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
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.isScrollEnabled = false
        // Do any additional setup after loading the view.
    }
    @IBAction func expandCategoryButtonAction(_ sender: Any) {
        if expandableCategoryControl == false {
            UIView .animate(withDuration: 0.3) {
                self.heightOfExpandableViewConstraint.constant = 250.0
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
            }
            self.scrollView.isScrollEnabled = true
            expandableCategoryControl = true
        } else {
            UIView .animate(withDuration: 0.3) {
                self.heightOfExpandableViewConstraint.constant = 0.0
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
            }
            scrollView.setContentOffset(.zero, animated: true)
            expandableCategoryControl = false
            self.scrollView.isScrollEnabled = false
        }
    }
}
