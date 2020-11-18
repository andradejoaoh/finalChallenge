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
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var AvanceButton: UIButton!
    
    var fullname = String()
    var bio = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDelegateForTextFields()
        setupStyleForElements()
        errorLabel.text = ""
        self.hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    //self.performSegue(withIdentifier: "segue", sender: self)
    
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
    
    
    func validateFields() -> Bool? {
        //Check if fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            errorLabel.text = "Preencha o campo de email"
            return false
        } else if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            errorLabel.text = "Preencha o campo de senha"
            return false
        } else {
            return true
        }
    }
    
    
    @IBAction func unwindToEmailPasswordContent(segue:UIStoryboardSegue) {}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if validateFields() == true && (segue.identifier == "segueToNameSwipeGesture" || segue.identifier == "segueToName"){
            let destinationController = segue.destination as! SignUpViewControllerName
            destinationController.fullname = fullname
            destinationController.bio = bio
            destinationController.email = emailTextField.text!
            destinationController.senha = passwordTextField.text!
        } else {
            print("Textos nao inseridos nada acontece")
        }
        
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (validateFields() == true) && (identifier == "segueToNameSwipeGesture" || identifier == "segueToName") {
            return true
        } else if (validateFields() == false || validateFields() == true) && identifier == "unwindToFullNameBio" {
            return true
        } else {
            return false
        }
    }
    
    
}
