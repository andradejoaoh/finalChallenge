//
//  SignUpViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 03/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        imagePicker.delegate = self
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
            guard let imageData = profileImageView.image?.jpegData(compressionQuality: 0.5) else { return }

            // Create the user
            DatabaseHandler.signUpWithEmail(email: email, password: password, adress: adress, fullname: fullname, imageData: imageData) { (result) in
                switch result {
                case let .failure(error):
                    print(error)
                case .success:
                    self.transitionToProfile()
                }
            }
        }
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.profileImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    func validateFields() -> String? {
        //Check if fields are filled in
        if fullNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            adressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            profileImageView.image == nil {
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
