//
//  CreatAnnoucementViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit
import CoreLocation

/*
 
 Telefone e email do usuário.
 O resto foi criado.
 
 Campos oficiais:
 
 Imagem
 Nome do anuncio
 Descrição do anuncio
 Categoria do anuncio
 Preco do anuncio
 Tempo do anuncio
 Bairro do anuncio
 Switch do telefone (usuario)
 Switch do email (usuario)
 
 */


class CreateAnnoucementViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UITextViewDelegate{
    
    var annoucementImage: Data?
    
    
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
        
        self.annoucementNameTextField.delegate = self
        self.annoucementDescriptionTextView.delegate = self
        
        placeholderForTextView()
        
        setupStyleForElements()
        self.hideKeyboardWhenTappedAround()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    
    @IBAction func annouceAction(_ sender: Any) {
        
        print(annoucementImage)
        print(annoucementNameTextField.text!)
        print(annoucementDescriptionTextView.text!)
        print(annoucementCategory)
        print(annoucementPriceTextField.text!)
        print(annoucementTime)
        print(annoucementBairro)
        print(annoucementEmailSwitch.isOn)
        print(annoucementTelefoneSwitch.isOn)
        
        
        if validateFields() != nil {
            //Show fill all fields error
        } else {
            let geoCoder = CLGeocoder()
            
            let annoucementName = annoucementNameTextField.text!
            let annoucementDescription = annoucementDescriptionTextView.text!
            let annoucementPrice = annoucementPriceTextField.text!
            //category
            let price = Float(annoucementPriceTextField.text!) ?? 0.0
            //tempo
            //bairro
            let emailCheck = annoucementEmailSwitch.isOn
            let telefoneCheck = annoucementTelefoneSwitch.isOn
            
            guard let imageData = annoucementImage else { return }
            
            let expirationDate = Date(timeIntervalSinceNow: TimeInterval(annoucementTime))
            
            geoCoder.geocodeAddressString("\(annoucementBairro) - São Paulo") {(placemarks, error) in
                guard error == nil else {
                    return
                }
                let placemark = placemarks?.first
                let lat = placemark?.location?.coordinate.latitude
                let long = placemark?.location?.coordinate.longitude
                DatabaseHandler.createAnnoucement(annoucementName: annoucementName, annoucementDescription: annoucementDescription, annoucementLocation: self.annoucementBairro, annoucementImage: imageData, expirationDate: expirationDate, price: price, coordinates: (lat, long), category: self.annoucementCategory, emailCheck: emailCheck, telefoneCheck: telefoneCheck) { (result) in
                    switch result {
                    case let .failure(error):
                        //Show error while creating annoucement.
                        print(error)
                    case .success:
                        break
                    }
                }

            }
            self.navigationController?.popViewController(animated: true)
        }
         
    }
    
    
    func validateFields() -> String? {
        //Check if fields are filled in
        if annoucementNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Preencha corretamente o nome"
        } else if annoucementDescriptionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "preencha corretamente a descricao"
        } else if annoucementPriceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "preencha corretamente o preco"
        } else if annoucementTime == 0 {
            return "preencha corretamente o tempo"
        } else if annoucementBairro == "" {
            return "preencha corretamente o bairro"
        } else if annoucementCategory == "" {
            return "Preencha todos as categorias"
        }
        return nil
    }
    
    func setupStyleForElements(){
    }
    
    @IBAction func unwindCreateAnnoucement(segue:UIStoryboardSegue) {
        print(annoucementBairro)
    }
    
    @IBAction func unwindCreateAnnoucementFromHoras(segue:UIStoryboardSegue) {
        print(annoucementTime)
    }
    
    @IBAction func unwindCreateAnnoucementFromCategory(segue:UIStoryboardSegue) {
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
   
    
    
    //hide keyboard function
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



/**
 `UIPickerView protocols` used by two of the same.

 `HardConstants.swift` contains the data.

 - Author:
   João Henrique Andrade
*/


