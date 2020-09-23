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
    @IBOutlet weak var annoucementTimePicker: UIPickerView!
    
    @IBOutlet weak var selectPictureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.annoucementNameTextField.delegate = self
        self.annoucementDescriptionTextField.delegate = self
        self.productTypePicker.delegate = self
        self.productTypePicker.dataSource = self
        
        productTypePicker.tag = 1
        annoucementTimePicker.tag = 2
        
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
