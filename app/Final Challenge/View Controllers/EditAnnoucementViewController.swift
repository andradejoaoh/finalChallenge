//
//  EditAnnoucementViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 09/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class EditAnnoucementViewController: UIViewController {
    var annoucement: Annoucement?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var productTypePicker: UIPickerView!
    @IBOutlet weak var deliveryOption: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTypePicker.delegate = self
        productTypePicker.dataSource = self
        
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
        
        DatabaseHandler.editAnnoucement(annoucementID: annoucement.annoucementID, annoucementName: name, annoucementLocation: location, annoucementDescription: description, deliveryOption: false, productType: "Comida") { (result) in
            switch result {
            case let .failure(error):
                //Error while updating annoucement
                print(error)
            case .success:
                self.navigationController?.popViewController(animated: true)
            }
        }
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
