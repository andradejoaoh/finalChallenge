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
    
    
    var teste: Bool = true
 
    
    var email = String()
    var senha = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDelegateForTextFields()
        setupStyleForElements()
        self.hideKeyboardWhenTappedAround()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    
    
    func validateFields() -> Bool? {
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return false
        } else {
            return true
        }
       
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
    
    @IBAction func unwindToNameContent(segue:UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToBemVindo" || segue.identifier == "segueSwipeGestureToBemVindo" {
            if validateFields() == true {
                let destinationController = segue.destination as! SignUpViewControllerBemVindo
                destinationController.email = email
                destinationController.senha = senha
                destinationController.name = nameTextField.text!
            } else {
                print("textos n preenchidos")
            }
            
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (validateFields() == true) && (identifier == "segueToBemVindo" || identifier == "segueSwipeGestureToBemVindo") {
            return true
        } else if (validateFields() == false || validateFields() == true) && identifier == "unwindToEmailPassword" {
            return true
        } else {
            return false
        }
    }
    

    
    //hide keyboard function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
 
    
}

