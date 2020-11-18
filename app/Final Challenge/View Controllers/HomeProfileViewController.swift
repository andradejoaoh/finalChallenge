//
//  ViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 31/08/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class HomeProfileViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var orangeView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if DatabaseHandler.isUserLoggedIn() {
            transitionToProfile()
        }
        errorLabel.text = ""
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        setupStyleElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if DatabaseHandler.isUserLoggedIn() {
            if let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: HardConstants.Storyboard.profileViewController), let navigationController = self.navigationController{
                navigationController.setViewControllers([profileViewController], animated: true)
            }
        }
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func transitionToProfile(){
        if let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: HardConstants.Storyboard.profileViewController), let navigationController = self.navigationController{
            navigationController.setViewControllers([profileViewController], animated: true)
        }
    }
    
    @IBAction func unwindToHomeProfileContent(segue:UIStoryboardSegue) {}

    
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
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            errorLabel.text = "Preencha o campo de email"
            return "Preencha todos os campos."
        } else if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            errorLabel.text = "Preencha o campo de senha"
            return "Preencha todos os campos."
        }
        errorLabel.text = ""
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
        orangeView.layer.cornerRadius = 15
        orangeView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        StyleElements.styleTextField(emailTextField)
        StyleElements.styleTextField(passwordTextField)
        //StyleElements.styleFilledButton(loginButton)
        loginButton.backgroundColor = UIColor(named: "button")
        loginButton.layer.cornerRadius = 15
    }
}

