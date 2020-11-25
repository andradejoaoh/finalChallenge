//
//  EditProfileViewController.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 20/11/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    var userProfile: User?
    
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imagemPerfil: UIImageView!
    
    
    @IBOutlet weak var nameMarcaTextField: UITextField!
    
    @IBOutlet weak var namePerfilTextField: UITextField!
    

    @IBOutlet weak var categoryButtonOutlet: UIButton!
    
    
    @IBOutlet weak var nameAdressTextField: UITextField!
    
    @IBOutlet weak var numberContactTextField: UITextField!
    
    @IBOutlet weak var siteTextField: UITextField!
    
    @IBOutlet weak var instagramTextField: UITextField!
    
    @IBOutlet weak var facebookTextField: UITextField!
    
    @IBOutlet weak var telegramTextField: UITextField!
    
    @IBOutlet weak var heightOfViewLinks: NSLayoutConstraint!//131
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var expandableViewLinksControl: Bool = false
    
    var lastImage: Data?
    
    var profileImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        imagePicker.delegate = self
        setupStyleForElements()
        self.hideKeyboardWhenTappedAround()
        guard let user = userProfile else { return }
        lastImage = user.imageData
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func changePerfilImage(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.imagemPerfil.image = image
        guard let user = userProfile else { return }
        user.imageData = image.jpegData(compressionQuality: 0.5)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func buttonToLinksAction(_ sender: Any) {
        if expandableViewLinksControl == false {
            UIView.animate(withDuration: 0.3) {
                self.scrollView.isScrollEnabled = true
                self.heightOfViewLinks.constant = 131.0
                self.view.setNeedsUpdateConstraints()
                //self.verTudoButtonOutlet.setTitle("Minimizar", for: .normal)
                self.view.layoutIfNeeded()
            }
            expandableViewLinksControl = true
        } else {
            UIView .animate(withDuration: 0.3) {
                self.heightOfViewLinks.constant = 0.0
                self.view.setNeedsUpdateConstraints()
                //self.verTudoButtonOutlet.setTitle("Ver tudo", for: .normal)
                self.view.layoutIfNeeded()
            }
            scrollView.setContentOffset(.zero, animated: true)
            expandableViewLinksControl = false
            self.scrollView.isScrollEnabled = false
        }
    }
    
    //style for elements
    func setupStyleForElements(){
        scrollView.isScrollEnabled = false
        imagemPerfil.layer.cornerRadius = 35
        
        if let user = userProfile {
            imagemPerfil.image = UIImage(data: user.imageData ?? Data())
            nameMarcaTextField.text = user.userStoreName
            namePerfilTextField.text = user.userName
            categoryButtonOutlet.setTitle(user.userCategory, for: .normal)
            nameAdressTextField.text = user.userAddress
            numberContactTextField.text = user.userPhone
            siteTextField.text = user.userSite
            instagramTextField.text = user.userInstagram
            facebookTextField.text = user.userFacebook
            telegramTextField.text = user.userTelegram
        }
        
    }
    
    func validateFields() -> String? {
        if nameMarcaTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            errorLabel.text = "Preencha corretamente o nome da marca"
            return "Preencha corretamente o nome da marca"
        } else if namePerfilTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            errorLabel.text = "Preencha corretamente o nome completo"
            return "Preencha corretamente o nome completo"
        } else if nameAdressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            errorLabel.text = "Preencha corretamente o endereço"
            return "Preencha corretamente o endereço"
        } else if numberContactTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            errorLabel.text = "Preencha corretamente o telefone"
            return "Preencha corretamente o telefone"
        }
        errorLabel.text = ""
        return nil
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    @IBAction func unwindToEditProfile(segue:UIStoryboardSegue) {
        guard let user = userProfile else { return }
        categoryButtonOutlet.setTitle(user.userCategory, for: .normal)
    }
    
    
    @IBAction func sairContaAction(_ sender: Any) {
        let signOutAlert = UIAlertController(title: "Deseja Sair?", message: "Você poderá fazer login quando quiser novamente.", preferredStyle: .alert)
        signOutAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        signOutAlert.addAction(UIAlertAction(title: "Sair", style: .destructive, handler: { (UIAlertAction) in
            DatabaseHandler.signOut()
            if let homeProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: HardConstants.Storyboard.homeProfileViewController), let navigationController = self.navigationController{
                navigationController.setViewControllers([homeProfileViewController], animated: true)
            }
        }))
        self.present(signOutAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func saveEditProfileAction(_ sender: Any) {
        guard let user = userProfile else { return }
        if validateFields() != nil {
            //show error label
        } else {
            if let userID = DatabaseHandler.getCurrentUser() {
                
                let storeName = nameMarcaTextField.text!
                let fullName = namePerfilTextField.text!
                let category = user.userCategory
                let localization = nameAdressTextField.text!
                let contact = numberContactTextField.text!
                let site = siteTextField.text ?? ""
                let instagram = instagramTextField.text ?? ""
                let facebook = facebookTextField.text ?? ""
                let telegram = telegramTextField.text ?? ""
                
                if lastImage == self.imagemPerfil.image?.jpegData(compressionQuality: 1) {
                    DatabaseHandler.editProfile(imageData: nil, userID: userID, storeName: storeName, fullName: fullName, category: category, localization: localization, contact: contact, site: site, instagram: instagram, facebook: facebook, telegram: telegram){ (result) in
                        switch result {
                        case let .failure(error):
                            //Error while updating perfil
                            print(error)
                        case .success:
                            
                            user.userStoreName = storeName
                            user.userName = fullName
                            user.userCategory = category
                            user.userAddress = localization
                            user.userPhone = contact
                            user.userSite = site
                            user.userInstagram = instagram
                            user.userFacebook = facebook
                            user.userTelegram = telegram
                            
                            
                        }
                    }
                } else {
                    let imageData = user.imageData
                    DatabaseHandler.editProfile(imageData: imageData, userID: userID, storeName: storeName, fullName: fullName, category: category, localization: localization, contact: contact, site: site, instagram: instagram, facebook: facebook, telegram: telegram) { (result) in
                        switch result {
                        case let .failure(error):
                            //Error while updating user
                            print(error)
                        case .success:
                            //self.userProfile
                            
                            user.userStoreName = storeName
                            user.userName = fullName
                            user.userCategory = category
                            user.userAddress = localization
                            user.userPhone = contact
                            user.userSite = site
                            user.userInstagram = instagram
                            user.userFacebook = facebook
                            user.userTelegram = telegram
                            
                            //self.performSegue(withIdentifier: "unwindToMainProfile", sender: self)
                            //talvez uma perform segue aqui
                            
                        }
                    }
                }
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "unwindToMainProfile" {
//            let destinationController =  segue.destination as! ProfileViewController
//            destinationController.imageReceivedFromEdited.image = imagemPerfil.image
//        }
//    }
    
}


