//
//  SignUpViewControllerName.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 10/11/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import UIKit


class SignUpViewControllerName: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var AvanceButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    
    var email = String()
    var senha = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDelegateForTextFields()
        setupStyleForElements()
        self.hideKeyboardWhenTappedAround()
        
//        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe(sender:)))
//        swipeGesture.direction = .right
//        func swipeLeft(recognizer : UISwipeGestureRecognizer){
//        }
    }
    
//    @objc func rightSwipe(sender: UISwipeGestureRecognizer){
//        self.performSegue(withIdentifier: "segueBackToEmailPassword", sender: self)
//    }
    //segueBackToEmailPassword
    
    
    func validateFields() -> String? {
        //Check if fields are filled in
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Preencha todos os campos."
        }
        return nil
    }
    
    
    
    func setDelegateForTextFields(){
        self.nameTextField.delegate = self
        
    }
    
    //style for elements
    func setupStyleForElements(){
        StyleElements.styleTextField(nameTextField)
        AvanceButton.backgroundColor = UIColor(named: "button")
        AvanceButton.layer.cornerRadius = 15
        pageControl.currentPage = 1
    }
    
    //hide keyboard function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
 
    
}

