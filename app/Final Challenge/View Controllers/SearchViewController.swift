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
    
    @IBOutlet weak var sliderProximity: UISlider!
    @IBOutlet weak var heightOfExpandableViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var verTudoButtonOutlet: UIButton!
    @IBOutlet weak var heightOfProximityExpandableViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sliderLabel: UILabel!
    var expandableCategoryControl: Bool = false
    var expandableProximityControl: Bool = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        self.scrollView.isScrollEnabled = false
        sliderProximity.value = 6
        
        self.sliderLabel.text = "\(sliderProximity.value - 1) km"
        let trackRect = sliderProximity.trackRect(forBounds: sliderProximity.frame)
        let thumbRect = sliderProximity.thumbRect(forBounds: sliderProximity.bounds, trackRect: trackRect, value: sliderProximity.value)
        
        self.sliderLabel.center = CGPoint(x: thumbRect.midX, y: self.sliderLabel.center.y)
        
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
    
    @IBAction func sliderProximityAction(_ sender: UISlider) {
        
        sliderProximity.value = roundf(sliderProximity.value)
        self.sliderLabel.text = "\(sliderProximity.value - 1) km"
        if sliderProximity.value == 1 {
            self.sliderLabel.text = "500 m"
        }
//        let trackRect = sliderProximity.trackRect(forBounds: sliderProximity.frame)
//        let thumbRect = sliderProximity.thumbRect(forBounds: sliderProximity.bounds, trackRect: trackRect, value: sliderProximity.value)
//
//        self.sliderLabel.center = CGPoint(x: thumbRect.midX, y: self.sliderLabel.center.y)
    }
    
    
}
