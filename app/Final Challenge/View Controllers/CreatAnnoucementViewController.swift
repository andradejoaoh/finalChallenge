//
//  CreatAnnoucementViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class CreateAnnoucementViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var announceButton: UIButton!
    
    @IBOutlet weak var annoucementNameTextField: UITextField!
    @IBOutlet weak var annoucementDescriptionTextField: UITextField!
    @IBOutlet weak var annoucementLocationTextField: UITextField!

    @IBOutlet weak var deliveryOptionSwitch: UISwitch!
    @IBOutlet weak var productTypePicker: UIPickerView!
    
    @IBOutlet weak var selectPictureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.annoucementNameTextField.delegate = self
        self.annoucementDescriptionTextField.delegate = self
        self.productTypePicker.delegate = self
        self.productTypePicker.dataSource = self
        
        setupStyleForElements()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func annouceAction(_ sender: Any) {
        if validateFields() != nil {
            //Show fill all fields error
        } else {
            
            let annoucementName = annoucementNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let annoucementDescription = annoucementDescriptionTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let annoucementLocation = annoucementLocationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let deliveryOption = deliveryOptionSwitch.isOn
            let productType = "Comida"
            
            DatabaseHandler.createAnnoucement(annoucementName: annoucementName, annoucementDescription: annoucementDescription, annoucementLocation: annoucementLocation, deliveryOption:  deliveryOption, productType: productType) { (result) in
                switch result {
                case let .failure(error):
                    //Show error while creating annoucement.
                    print(error)
                case .success:
                    break
                }
            }
            self.navigationController?.popViewController(animated: true)
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
    }
}

extension CreateAnnoucementViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        HardConstants.PickerView.productType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        HardConstants.PickerView.productType[row]
    }
    
}
