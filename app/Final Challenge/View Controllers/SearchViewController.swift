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
    
    @IBOutlet weak var ExpandableProximityView: UIView!
    
    @IBOutlet weak var heightOfExpandableViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var verTudoButtonOutlet: UIButton!
    @IBOutlet weak var heightOfProximityExpandableViewConstraint: NSLayoutConstraint!
    
    var expandableCategoryControl: Bool = false
    var expandableProximityControl: Bool = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.isScrollEnabled = false
        // Do any additional setup after loading the view.
    }
    @IBAction func expandCategoryButtonAction(_ sender: Any) {
        if expandableCategoryControl == false {
            UIView.animate(withDuration: 0.3) {
                self.heightOfExpandableViewConstraint.constant = 250.0
                self.view.setNeedsUpdateConstraints()
                self.verTudoButtonOutlet.setTitle("Minimizar", for: .normal)
                self.view.layoutIfNeeded()
            }
            
            self.scrollView.isScrollEnabled = true
            expandableCategoryControl = true
        } else {
            UIView .animate(withDuration: 0.3) {
                self.heightOfExpandableViewConstraint.constant = 0.0
                self.view.setNeedsUpdateConstraints()
                self.verTudoButtonOutlet.setTitle("Ver tudo", for: .normal)
                self.view.layoutIfNeeded()
            }
            
            scrollView.setContentOffset(.zero, animated: true)
            expandableCategoryControl = false
            self.scrollView.isScrollEnabled = false
        }
    }
    
    
    @IBAction func proximityExpandableAction(_ sender: Any) {
        if expandableProximityControl == false {
            UIView.animate(withDuration: 0.3) {
                self.heightOfProximityExpandableViewConstraint.constant = 100.0
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
            }
            expandableProximityControl = true
        } else {
            UIView.animate(withDuration: 0.3) {
                self.heightOfProximityExpandableViewConstraint.constant = 0
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
            }
            expandableProximityControl = false
        }
    }
}
