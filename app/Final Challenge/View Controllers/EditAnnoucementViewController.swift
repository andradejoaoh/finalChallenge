//
//  EditAnnoucementViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 09/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class EditAnnoucementViewController: UIViewController, UITextFieldDelegate {
    var annoucement: Annoucement?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var productTypePicker: UIPickerView!
    @IBOutlet weak var deliveryOption: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTypePicker.delegate = self
        productTypePicker.dataSource = self
        
        nameTextField.delegate = self
        descriptionTextField.delegate = self
        locationTextField.delegate = self
        priceTextField.delegate = self
        
        setupStyleForElements()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let annoucement = annoucement {
            nameTextField.text = annoucement.annoucementName
            descriptionTextField.text = annoucement.description
            locationTextField.text = annoucement.location
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
        guard let annoucement = annoucement else { return }
        
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let description = descriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let location = locationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        let productType: String = HardConstants.PickerView.productType[productTypePicker.selectedRow(inComponent: 0)]
        let deliveryOpt: Bool = deliveryOption.isOn
        
        DatabaseHandler.editAnnoucement(annoucementID: annoucement.annoucementID, annoucementName: name, annoucementLocation: location, annoucementDescription: description, deliveryOption: deliveryOpt, productType: productType) { (result) in
            switch result {
            case let .failure(error):
                //Error while updating annoucement
                print(error)
            case .success:
                annoucement.annoucementName = name
                annoucement.description = description
                annoucement.location = location
                annoucement.productType = productType
                annoucement.deliveryOption = deliveryOpt
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setupStyleForElements(){
        StyleElements.styleTextField(nameTextField)
        StyleElements.styleTextField(descriptionTextField)
        StyleElements.styleTextField(locationTextField)
        StyleElements.styleTextField(priceTextField)
        StyleElements.styleFilledButton(editButton)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
            descriptionTextField.becomeFirstResponder()
        } else if textField == descriptionTextField {
            textField.resignFirstResponder()
            locationTextField.becomeFirstResponder()
        } else if textField == locationTextField {
            textField.resignFirstResponder()
            priceTextField.becomeFirstResponder()
        } else if textField == priceTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension EditAnnoucementViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
