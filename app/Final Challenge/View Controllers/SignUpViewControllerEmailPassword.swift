//
//  SignUpViewControllerEmailPassword.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 09/11/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewControllerEmailPassword: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var AvanceButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDelegateForTextFields()
        setupStyleForElements()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    
    func validateFields() -> String? {
        //Check if fields are filled in
        if
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Preencha todos os campos."
        }
        return nil
    }
    
    
    
    func setDelegateForTextFields(){
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    //style for elements
    func setupStyleForElements(){
        StyleElements.styleTextField(emailTextField)
        StyleElements.styleTextField(passwordTextField)
        AvanceButton.backgroundColor = UIColor(named: "button")
        AvanceButton.layer.cornerRadius = 15
        pageControl.currentPage = 1
    }
    
    //hide keyboard function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
