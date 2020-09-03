//
//  SignUpViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 03/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        //Validate the fields
        let error = validateFields()
        
        if error != nil {
            // Show Error
        } else {
            //Clear data for usage
            let fullname = self.fullNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = self.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = self.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let adress = self.adressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    // There was an error
                    print(error)
                } else {
                    // User created sucessfully
                    // Store user information
                    let database = Firestore.firestore()
                    database.collection("users").addDocument(data: ["full_name":fullname,
                                                                    "adress":adress,
                                                                    "uid":result!.user.uid]) { (error) in
                                                                        if error != nil {
                                                                            // Show error message
                                                                        }
                    }
                }
            }
            // Transition to the profile screen
            transitionToProfile()
        }
    }
    
    func validateFields() -> String? {
        //Cheeck if fields are filled in
        if fullNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            adressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Preencha todos os campos."
        }
        
        return nil
    }
    
    func transitionToProfile(){
        let profileViewController = storyboard?.instantiateViewController(identifier: HardConstants.Storyboard.profileViewController) as? ProfileViewController
        view.window?.rootViewController = profileViewController
        view.window?.makeKeyAndVisible()
    }
}
