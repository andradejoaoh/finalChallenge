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
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var bioTextView: UITextView!
    
    @IBOutlet weak var AvanceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupStyleForElements()
        bioTextView.delegate = self
        placeholderForTextView()
        errorLabel.text = ""
        self.hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func placeholderForTextView(){
        bioTextView.text = "Coloque a descrição da sua loja..."
        bioTextView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor(named: "text")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Coloque a descrição da sua loja..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    //self.performSegue(withIdentifier: "segue", sender: self)
    
    //style for elements
    func setupStyleForElements(){
        StyleElements.styleTextField(fullNameTextField)
        AvanceButton.backgroundColor = UIColor(named: "button")
        AvanceButton.layer.cornerRadius = 15
        pageControl.currentPage = 0
        bioTextView.layer.borderWidth = 1
        bioTextView.layer.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        bioTextView.layer.cornerRadius = 5
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
        if fullNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            errorLabel.text = "Preencha o campo do nome"
            return false
        } else if bioTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            errorLabel.text = "Preencha o campo de descrição"
            return false
        } else {
            errorLabel.text = ""
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
