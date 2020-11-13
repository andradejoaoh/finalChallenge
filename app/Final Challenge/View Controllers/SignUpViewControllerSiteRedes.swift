//
//  SignUpViewControllerSiteRedes.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 12/11/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewControllerSiteRedes: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
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
    
    @IBOutlet weak var linkSiteTextField: UITextField!
    
    @IBOutlet weak var linkInstagramTextField: UITextField!
    
    @IBOutlet weak var linkFacebookTextField: UITextField!
    
    @IBOutlet weak var linkTelegramTextField: UITextField!
    
    @IBOutlet weak var avanceButton: UIButton!
    
    @IBOutlet weak var pageControle: UIPageControl!
    
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
    
    func setupStyleForElements(){
        avanceButton.backgroundColor = UIColor(named: "button")
        avanceButton.layer.cornerRadius = 15
        pageControle.currentPage = 6
    }
    
    @IBAction func unwindToSiteRedes(segue:UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SwipeSegueToFinalCadastro" || segue.identifier == "segueToFinalCadastro" {
            let destinationController = segue.destination as! SignUpViewControllerFimCadastro
            destinationController.fullname = fullname
            destinationController.bio = bio
            destinationController.email = email
            destinationController.senha = senha
            destinationController.name = name
            destinationController.image = image
            destinationController.categoria = categoria
            destinationController.endereco = endereco
            destinationController.CEP = CEP
            destinationController.numeroEndereco = numeroEndereco
            destinationController.telefone = telefone
            destinationController.permissionLocationCheck = permissionLocationCheck
            destinationController.permissionTelefoneCheck = permissionTelefoneCheck
            destinationController.linkSite = linkSiteTextField.text!
            destinationController.linkInstagram = linkInstagramTextField.text!
            destinationController.linkFacebook = linkFacebookTextField.text!
            destinationController.linkTelegram = linkTelegramTextField.text!
        }
    }


    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        true
    }

}


