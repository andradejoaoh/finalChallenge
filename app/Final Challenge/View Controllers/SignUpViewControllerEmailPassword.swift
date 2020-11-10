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
        pageControl.currentPage = 0
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
    
    
    func validateFields() -> Bool? {
        //Check if fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return false
        } else {
            return true
        }
    }
    
    
    @IBAction func unwindToEmailPasswordContent(segue:UIStoryboardSegue) {}
    
    
//
//    func validateFields() -> String? {
//        //Check if fields are filled in
//        if fullNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            adressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            bioTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            profileImageView.image == nil {
//            return "Preencha todos os campos."
//        }
//        return nil
//    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if validateFields() == true{
            let destinationController = segue.destination as! SignUpViewControllerName
            destinationController.email = emailTextField.text!
            destinationController.senha = passwordTextField.text!
        } else {
            print("Textos nao inseridos nada acontece")
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if validateFields() == true {
            return true
        } else {
            return false
        }
    }
    
   
    
//    if validateFields() == true{
//        if segue.identifier == "segueToName" {
//            let destinationController = segue.destination as! SignUpViewControllerName
//            destinationController.email = emailTextField.text!
//            destinationController.senha = passwordTextField.text!
//        }
//    } else {
//        print("Textos nao inseridos nada acontece")
//    }
//
//    @IBAction func startBtn(_ sender: Any) {
//            if(emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//                passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
//                print("no text")
//                //Show alert message here
//            }else{
//
//                self.performSegue(withIdentifier: "segueToName", sender: self)
//                let destinationController = segue.destination as! SignUpViewControllerName
//                destinationController.email = emailTextField.text!
//                destinationController.senha = passwordTextField.text!
//
//
//            }
//        }
//
//    @IBAction func avanceAction(_ sender: Any) {
//
//
//    }
    
}
