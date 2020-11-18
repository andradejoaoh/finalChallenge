//
//  EditAnnoucementViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 09/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class EditAnnoucementViewController:  UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var annoucement: Annoucement?
        
    
    @IBOutlet weak var editBttnOutlet: UIButton!
    
    @IBOutlet weak var annoucementNameTextField: UITextField!

    @IBOutlet weak var annoucementDescriptionTextView: UITextView!
    
    //@IBOutlet weak var annoucementLocationTextField: UITextField!
    var annoucementCategory:String = ""
    
    @IBOutlet weak var annoucementPriceTextField: UITextField!
    
    var annoucementTime:Int = 0
        
    var annoucementBairro:String = ""
    
    @IBOutlet weak var annoucementTelefoneSwitch: UISwitch!
    
    @IBOutlet weak var annoucementEmailSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        annoucementNameTextField.text = annoucement?.annoucementName
        annoucementDescriptionTextView.text = annoucement?.description
        annoucementCategory = annoucement?.category ?? ""
        annoucementPriceTextField.text = String(annoucement?.price ?? 0)
        //annoucementTime = annoucement?.expirationDate APAGAR
        //annoucementBairro = annoucement?.location ?? "" APAGAR
        
        if annoucement?.telefoneCheck == true{
            annoucementTelefoneSwitch.isOn = true
        } else {
            annoucementTelefoneSwitch.isOn = false
        }
        
        if annoucement?.emailCheck == true {
            annoucementEmailSwitch.isOn = true
        } else {
            annoucementEmailSwitch.isOn = false
        }
    }
    
    func styleElements(){
        
        editBttnOutlet.backgroundColor = UIColor(named: "button")
        editBttnOutlet.layer.cornerRadius = 15
    }
    
    @IBAction func editAction(_ sender: Any) {
        
        
        guard let annoucement = annoucement else { return }
        
        if validateFields() != nil {
            //show error on label
        } else {
            let name = annoucementNameTextField.text!
            let description = annoucementDescriptionTextView.text!
            let category = annoucementCategory
            let price = Float(annoucementPriceTextField.text!)
            let telefoneCheck = annoucementTelefoneSwitch.isOn
            let emailCheck = annoucementEmailSwitch.isOn
            
            DatabaseHandler.editAnnoucement(annoucementID: annoucement.annoucementID, annoucementName: name, annoucementDescription: description, telefoneCheck: telefoneCheck, emailCheck: emailCheck, category: category, price: price ?? 0) { (result) in
                switch result {
                case let .failure(error):
                    //Error while updating annoucement
                    print(error)
                case .success:
                    annoucement.annoucementName = name
                    annoucement.description = description
                    annoucement.category = category
                    annoucement.price = price
                    annoucement.emailCheck = emailCheck
                    annoucement.telefoneCheck = telefoneCheck
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
 
        
    }
    
    
    func validateFields() -> String? {
        if annoucementNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Preencha corretamente o nome"
        } else if annoucementDescriptionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "preencha corretamente a descricao"
        } else if annoucementPriceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "preencha corretamente o preco"
        } else if annoucementCategory == "" {
            return "Preencha todos as categorias"
        }
        return nil
    }
    
    
    
    @IBAction func unwindEditBairroAnnoucement(segue:UIStoryboardSegue) {
        print(annoucementBairro)
    }
    
    @IBAction func unwindEditAnnoucementFromHoras(segue:UIStoryboardSegue) {
        print(annoucementTime)
    }
    
    @IBAction func unwindEditAnnoucementFromCategory(segue:UIStoryboardSegue) {
        print(annoucementCategory)
    }
    
    func placeholderForTextView(){
        annoucementDescriptionTextView.text = "Descreva seu produto..."
        annoucementDescriptionTextView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor(named: "text")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Descreva seu produto..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == annoucementNameTextField {
            textField.resignFirstResponder()
            annoucementDescriptionTextView.becomeFirstResponder()
        } else if textField == annoucementDescriptionTextView {
            textField.resignFirstResponder()
        }
        return true
    }
}


