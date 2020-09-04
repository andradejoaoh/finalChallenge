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
import FirebaseStorage

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
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    // There was an error
                    print(error)
                } else {
                    // User created sucessfully
                    // Upload User Profile Picture
                    let storage = Storage.storage(url: HardConstants.Database.storageURL)
                    let storageReference = storage.reference()
                    let profileImageReference = storageReference.child("profilePictures/\(result!.user.uid)")
                    guard let profileImageData = self.profileImageView.image?.jpegData(compressionQuality: 0.5) else { return }
                    
                    let uploadTask = profileImageReference.putData(profileImageData, metadata: nil) { (metadata, error) in
                        if error != nil {
                            //Show Error while uploading image
                        }
                        profileImageReference.downloadURL { (url, error) in
                            if error != nil {
                                //Show error while downloading image
                                return
                            }
                            if let url = url {
                                let database = Firestore.firestore()
                                database.collection("users").addDocument(data: ["full_name":fullname,
                                                                                "adress":adress,
                                                                                "uid":result!.user.uid,
                                                                                "profile_image_url":url.absoluteString]) { (error) in
                                                                                    if error != nil {
                                                                                        // Show error message
                                                                                    }
                                                                                    
                                }
                            }
                        }
                    }
                    uploadTask.resume()
                }
            }
            // Transition to the profile screen
            transitionToProfile()
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
