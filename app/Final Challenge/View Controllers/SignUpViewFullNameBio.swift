//
//  SignUpViewFullNameBio.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 13/11/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewControllerFullNameBio: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var bioTextView: UITextView!
    
    @IBOutlet weak var AvanceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupStyleForElements()
        
        self.hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    //self.performSegue(withIdentifier: "segue", sender: self)
    
    //style for elements
    func setupStyleForElements(){
        StyleElements.styleTextField(fullNameTextField)
        AvanceButton.backgroundColor = UIColor(named: "button")
        AvanceButton.layer.cornerRadius = 15
        pageControl.currentPage = 0
    }
    
    //hide keyboard function
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == fullNameTextField {
//            textField.resignFirstResponder()
//            passwordTextField.becomeFirstResponder()
//        } else if textField == passwordTextField {
//            textField.resignFirstResponder()
//        }
//        return true
//    }
    
    
    func validateFields() -> Bool? {
        //Check if fields are filled in
        if fullNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            bioTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return false
        } else {
            return true
        }
    }
    
    
    @IBAction func unwindToFullNameBioContent(segue:UIStoryboardSegue) {}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if validateFields() == true && (segue.identifier == "segueToNameSenha" || segue.identifier == "swipeSegueToEmailSenha"){
            let destinationController = segue.destination as! SignUpViewControllerEmailPassword
            destinationController.fullname = fullNameTextField.text!
            destinationController.bio = bioTextView.text!
        } else {
            print("Textos nao inseridos nada acontece")
        }
        
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (validateFields() == true) && (identifier == "segueToNameSenha" || identifier == "swipeSegueToEmailSenha") {
            return true
        } else if (validateFields() == false || validateFields() == true) && identifier == "unwindToHomeSegue" {
            return true
        } else {
            return false
        }
    }
    
    
}
