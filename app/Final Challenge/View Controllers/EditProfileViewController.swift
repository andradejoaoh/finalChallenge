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
    
    var fullname = String()
    var bio = String()
    var email = String()
    var senha = String()
    var name = String()
    var image = UIImageView()
    var categoria = String()
    var endereco = String()
    var CEP = String()
    var numeroEndereco = String()
    var permissionLocationCheck =  Bool()
    var telefone = String()
    var permissionTelefoneCheck = Bool()
    var linkSite = String()
    var linkInstagram = String()
    var linkFacebook = String()
    var linkTelegram = String()
    
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imagemPerfil: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.hideKeyboardWhenTappedAround()
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
        self.dismiss(animated: true, completion: nil)
    }
    
    //style for elements
    func setupStyleForElements(){
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }

}


