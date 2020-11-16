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
        
        print("ANUNCIADO")
        print(annoucementImage)
        print(annoucementNameTextField.text!)
        print(annoucementDescriptionTextView.text!)
        print(annoucementCategory)
        print(annoucementPriceTextField.text!)
        print(annoucementTime)
        print(annoucementBairro)
        print(annoucementEmailSwitch.isOn)
        print(annoucementTelefoneSwitch.isOn)
        /*
        if validateFields() != nil {
            //Show fill all fields error
        } else {
            let geoCoder = CLGeocoder()
            
            let annoucementName = annoucementNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let annoucementDescription = annoucementDescriptionTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let annoucementLocation = annoucementLocationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let deliveryOption = deliveryOptionSwitch.isOn
            let productType = HardConstants.PickerView.productType[productTypePicker.selectedRow(inComponent: 0)]
            let price = Float(annoucementPriceTextField.text!) ?? 0.0
            guard let imageData = annoucementImage else { return }
            
            var expirationDate: Double {
                switch HardConstants.PickerView.annoucementTime[annoucementTimePicker.selectedRow(inComponent: 0)] {
                case "1 hora":
                    return 3600
                case "2 horas":
                    return 7200
                case "4 horas":
                    return 14400
                case "6 horas":
                    return 21600
                case "8 horas":
                    return 28800
                case "12 horas":
                    return 43200
                case "16 horas":
                    return 57600
                case "2 dias":
                    return 172800
                default:
                    return 86400
                }
            }
            geoCoder.geocodeAddressString(annoucementLocation) {(placemarks, error) in
                guard error == nil else {
                    return
                }
                let placemark = placemarks?.first
                let lat = placemark?.location?.coordinate.latitude
                let long = placemark?.location?.coordinate.longitude
                DatabaseHandler.createAnnoucement(annoucementName: annoucementName, annoucementDescription: annoucementDescription, annoucementLocation: annoucementLocation, annoucementImage: imageData, deliveryOption:  deliveryOption, expirationDate: Date(timeIntervalSinceNow: expirationDate), productType: productType, price: price, coordinates: (lat, long)) { (result) in
                    switch result {
                    case let .failure(error):
                        //Show error while creating annoucement.
                        print(error)
                    case .success:
                        break
                    }
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
         */
    }
    
    
    func validateFields() -> String? {
        //Check if fields are filled in
        if annoucementNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || annoucementDescriptionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || annoucementPriceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || annoucementTime == 0 || annoucementBairro == "" || annoucementCategory == ""{
            return "Preencha todos os campos."
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


