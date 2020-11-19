//
//  SignUpViewControllerFimCadastro.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 12/11/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewControllerFimCadastro: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
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
    
    
    @IBOutlet weak var concluirButton: UIButton!
    
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
    
    
    
    
    @IBAction func concluirButtonAction(_ sender: Any) {
        let fullname = self.fullname.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = self.email.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = self.senha.trimmingCharacters(in: .whitespacesAndNewlines)
        let adress = self.endereco.trimmingCharacters(in: .whitespacesAndNewlines)
        let CEP = self.CEP.trimmingCharacters(in: .whitespacesAndNewlines)
        let bio = self.bio.trimmingCharacters(in: .whitespacesAndNewlines)
        let categoria = self.categoria.trimmingCharacters(in: .whitespacesAndNewlines)
        let numeroEndereco = self.numeroEndereco.trimmingCharacters(in: .whitespacesAndNewlines)
        let site = self.linkSite.trimmingCharacters(in: .whitespacesAndNewlines)
        let facebook = self.linkFacebook.trimmingCharacters(in: .whitespacesAndNewlines)
        let instagram = self.linkInstagram.trimmingCharacters(in: .whitespacesAndNewlines)
        let telegram = self.linkTelegram.trimmingCharacters(in: .whitespacesAndNewlines)
        let checkLocation = self.permissionLocationCheck
        let checkTelefone = self.permissionTelefoneCheck
        let storeName = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = self.telefone.trimmingCharacters(in: .symbols)
        
        guard let imageData = image.image?.jpegData(compressionQuality: 0.5) else { return }
        

        // Create the user
        DatabaseHandler.signUpWithEmail(email: email, password: password, address: adress, CEP: CEP, fullname: fullname, bio: bio, categoria: categoria, numeroEndereco: numeroEndereco, facebook: facebook, site: site, instagram: instagram, telegram: telegram, checkLocation: checkLocation, checkTelefone: checkTelefone, storeName: storeName, phone: phone, imageData: imageData) { (result) in
            switch result {
            case let .failure(error):
                print(error)
            case .success:
                self.transitionToProfile()
            }
        }
    }
    
    func transitionToProfile(){
        if let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: HardConstants.Storyboard.profileViewController), let navigationController = self.navigationController{
            navigationController.setViewControllers([profileViewController], animated: true)
        }
    }
    
    //style for elements
    func setupStyleForElements(){
        concluirButton.backgroundColor = UIColor(named: "button")
        concluirButton.layer.cornerRadius = 15
    }
    
    @IBAction func unwindToPessoaInfo(segue:UIStoryboardSegue) {}
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }

}


