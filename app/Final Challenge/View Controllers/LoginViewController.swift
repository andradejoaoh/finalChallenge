//
//  LoginViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 03/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
    func transitionToProfile(){
        performSegue(withIdentifier: "profileSegue", sender: nil)
//        let profileViewController = storyboard?.instantiateViewController(identifier: HardConstants.Storyboard.profileViewController) as? ProfileViewController
//        view.window?.rootViewController = profileViewController
//        view.window?.makeKeyAndVisible()
    }
}
