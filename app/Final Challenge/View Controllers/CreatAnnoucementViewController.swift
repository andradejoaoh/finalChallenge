//
//  CreatAnnoucementViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

/*
 Nome
 
 Descrição
 
 MUDAR O TIPO DO PRODUTO PARA BAIRRO
 
 Categoria do perfil transferindo para a página de produto
 
 Preço
 
 Telefone - ser um switch onde pega o numero do telefone do perfil para adicionar no produto também (mesma coisa da categoria)
 
 
 Delivey - TIRAR O DELIVERY E COLOCAR CONTATO TELEFONE
 
 
 Tempo do produto mantem
 Imagem do produto mantem
 
 
 Figma:
 Nome do produto

 Descrição

 Bairro

 Categoria do perfil na pág de produto

 Preço

 Telefone
 
 */


class CreateAnnoucementViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()
    var annoucementImage: Data?
    
    @IBOutlet weak var announceButton: UIButton!
    
    @IBOutlet weak var annoucementNameTextField: UITextField!
    @IBOutlet weak var annoucementDescriptionTextField: UITextField!
    @IBOutlet weak var annoucementLocationTextField: UITextField!
    @IBOutlet weak var annoucementPriceTextField: UITextField!
    
    @IBOutlet weak var deliveryOptionSwitch: UISwitch!
    @IBOutlet weak var productTypePicker: UIPickerView!
    @IBOutlet weak var annoucementTimePicker: UIPickerView!
    
    @IBOutlet weak var selectPictureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.annoucementNameTextField.delegate = self
        self.annoucementDescriptionTextField.delegate = self
        self.annoucementLocationTextField.delegate = self
        
        self.productTypePicker.delegate = self
        self.productTypePicker.dataSource = self
        self.annoucementTimePicker.delegate = self
        self.annoucementTimePicker.dataSource = self
                
        self.imagePicker.delegate = self
        
        setupStyleForElements()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.productTypePicker.tag = 1
        self.annoucementTimePicker.tag = 2
    }
    
    @IBAction func annouceAction(_ sender: Any) {
        if validateFields() != nil {
            //Show fill all fields error
        } else {
            
            let annoucementName = annoucementNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let annoucementDescription = annoucementDescriptionTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let annoucementLocation = annoucementLocationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let deliveryOption = deliveryOptionSwitch.isOn
            let productType = HardConstants.PickerView.productType[productTypePicker.selectedRow(inComponent: 0)]
            let price = Float(annoucementPriceTextField.text!) ?? 0.0

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
            
            guard let imageData = annoucementImage else { return }
            DatabaseHandler.createAnnoucement(annoucementName: annoucementName, annoucementDescription: annoucementDescription, annoucementLocation: annoucementLocation, annoucementImage: imageData, deliveryOption:  deliveryOption, expirationDate: Date(timeIntervalSinceNow: expirationDate), productType: productType, price: price) { (result) in
                switch result {
                case let .failure(error):
                    //Show error while creating annoucement.
                    print(error)
                case .success:
                    break
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func validateFields() -> String? {
        //Check if fields are filled in
        if annoucementNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            annoucementLocationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            annoucementDescriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Preencha todos os campos."
        }
        return nil
    }
    
    func setupStyleForElements(){
        StyleElements.styleFilledButton(announceButton)
        StyleElements.styleFilledButton(selectPictureButton)
        StyleElements.styleTextField(annoucementNameTextField)
        StyleElements.styleTextField(annoucementDescriptionTextField)
        StyleElements.styleTextField(annoucementLocationTextField)
        StyleElements.styleTextField(annoucementPriceTextField)
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.annoucementImage = image.jpegData(compressionQuality: 0.8)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //hide keyboard function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == annoucementNameTextField {
            textField.resignFirstResponder()
            annoucementLocationTextField.becomeFirstResponder()
        } else if textField == annoucementLocationTextField {
            textField.resignFirstResponder()
            annoucementDescriptionTextField.becomeFirstResponder()
        } else if textField == annoucementDescriptionTextField {
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
extension CreateAnnoucementViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return HardConstants.PickerView.productType.count
        } else {
            return HardConstants.PickerView.annoucementTime.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return HardConstants.PickerView.productType[row]
        } else {
            return HardConstants.PickerView.annoucementTime[row]
        }
    }
}
