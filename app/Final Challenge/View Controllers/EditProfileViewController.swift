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
    
    
    @IBOutlet weak var nameMarcaTextField: UITextField!
    
    @IBOutlet weak var namePerfilTextField: UITextField!
    

    @IBOutlet weak var categoryButtonOutlet: UIButton!
    
    
    @IBOutlet weak var nameAdressTextField: UITextField!
    
    @IBOutlet weak var numberAdressTextField: UITextField!
    
    @IBOutlet weak var siteTextField: UITextField!
    
    @IBOutlet weak var instagramTextField: UITextField!
    
    @IBOutlet weak var facebookTextField: UITextField!
    
    @IBOutlet weak var telegramTextField: UITextField!
    
    @IBOutlet weak var heightOfViewLinks: NSLayoutConstraint!//131
    
    @IBOutlet weak var scrollView: UIScrollView!
    var expandableViewLinksControl: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        setupStyleForElements()
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
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    @IBAction func unwindToEditProfile(segue:UIStoryboardSegue) {
        print(categoria)
        categoryButtonOutlet.setTitle(categoria, for: .normal)
    }
    
    
    @IBAction func sairContaAction(_ sender: Any) {
    }
    
}


