//
//  SignUpViewControllerPessoalInfo.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 12/11/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewControllerPessoalInfo: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var EnderecoTextField: UITextField!
    
    @IBOutlet weak var CEPTextField: UITextField!
    
    @IBOutlet weak var NumeroEnderecoTextField: UITextField!
    
    @IBOutlet weak var buttonCheckLocation: UIButton!
    
    @IBOutlet weak var telefoneTextField: UITextField!
    
    @IBOutlet weak var buttonCheckTelefone: UIButton!
    
    @IBOutlet weak var avanceButton: UIButton!
    
    var fullname = String()
    var bio = String()
    var email = String()
    var senha = String()
    var name = String()
    var image = UIImageView()
    var categoria = String()
    
    
    
    
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
    
    
    @IBAction func buttonCheckLocationAction(_ sender: UIButton) {
        if EnderecoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && CEPTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && NumeroEnderecoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            if sender.isSelected {
                sender.isSelected = false
            } else {
                sender.isSelected = true
            }
        }
        
    }
    
    
    @IBAction func buttonCheckTelefoneAction(_ sender: UIButton) {
        if telefoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            if sender.isSelected {
                sender.isSelected = false
            } else {
                sender.isSelected = true
            }
        }
        
    }
    
    
    func validateFields() -> Bool? {
        if EnderecoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || CEPTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || NumeroEnderecoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || telefoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return false
        } else {
            return true
        }
    }

    
    //style for elements
    func setupStyleForElements(){
        avanceButton.backgroundColor = UIColor(named: "button")
        avanceButton.layer.cornerRadius = 15
        pageControl.currentPage = 5
    }
    
    @IBAction func unwindToPessoaInfo(segue:UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "swipeSegueToSiteRedes" || segue.identifier == "segueToSiteRedes" {
            let destinationController = segue.destination as! SignUpViewControllerSiteRedes
            destinationController.fullname = fullname
            destinationController.bio = bio
            destinationController.email = email
            destinationController.senha = senha
            destinationController.name = name
            destinationController.image = image
            destinationController.categoria = categoria
            destinationController.endereco = EnderecoTextField.text!
            destinationController.CEP = CEPTextField.text!
            destinationController.numeroEndereco = NumeroEnderecoTextField.text!
            destinationController.telefone = telefoneTextField.text!
            destinationController.permissionLocationCheck = buttonCheckLocation.isSelected
            destinationController.permissionTelefoneCheck = buttonCheckTelefone.isSelected
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "unwindToCategoria" && (validateFields() == true || validateFields() == false) {
            return true
        } else if (identifier == "swipeSegueToSiteRedes" || identifier == "segueToSiteRedes") && validateFields() == true {
            return true
        } else {
            return false
        }
    }
    

}

