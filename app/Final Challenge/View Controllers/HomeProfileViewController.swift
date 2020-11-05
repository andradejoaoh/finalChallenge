//
//  ViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 31/08/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class HomeProfileViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if DatabaseHandler.isUserLoggedIn() {
            transitionToProfile()
        }
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if DatabaseHandler.isUserLoggedIn() {
            if let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: HardConstants.Storyboard.profileViewController), let navigationController = self.navigationController{
                navigationController.setViewControllers([profileViewController], animated: true)
            }
        }
    }

    
    
    
    func transitionToProfile(){
        let profileViewController = storyboard?.instantiateViewController(identifier: HardConstants.Storyboard.profileViewController) as? ProfileViewController
        view.window?.rootViewController = profileViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToProfile(){
        if let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: HardConstants.Storyboard.profileViewController), let navigationController = self.navigationController{
            navigationController.setViewControllers([profileViewController], animated: true)
        }
    }
    
   
    
    @IBAction func loginAction(_ sender: Any) {
        //Validate Text Fields
        let error = self.validateFields()
        
        if error != nil {
            //Show error
        } else {
            //Create clean data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //SignIn with user credentials
            DatabaseHandler.loginWithEmail(email: email, password: password) { (result) in
                switch result {
                case let .failure(error):
                    //Show error while logging in
                    print(error)
                case .success:
                    self.transitionToProfile()
                }
            }
        }
    }
    
    func validateFields() -> String? {
        //Cheeck if fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Preencha todos os campos."
        }
        return nil
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    func setupStyleElements(){
        StyleElements.styleTextField(emailTextField)
        StyleElements.styleTextField(passwordTextField)
        StyleElements.styleFilledButton(loginButton)
    }
}

