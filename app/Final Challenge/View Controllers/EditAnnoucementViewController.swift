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
    
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var descriptionTextField: UITextField!
//    @IBOutlet weak var locationTextField: UITextField!
//    @IBOutlet weak var priceTextField: UITextField!
//    @IBOutlet weak var editButton: UIButton!
//    @IBOutlet weak var productTypePicker: UIPickerView!
//    @IBOutlet weak var deliveryOption: UISwitch!
    
    
    
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
        
        
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        /*
        if let annoucement = annoucement {
            nameTextField.text = annoucement.annoucementName
            descriptionTextField.text = annoucement.description
            locationTextField.text = annoucement.location
        }
 */
    }
    
    @IBAction func editAction(_ sender: Any) {
        
        /*
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
 */
    }
    
    
    func validateFields() -> String? {
        //Check if fields are filled in
        if annoucementNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || annoucementDescriptionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || annoucementPriceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || annoucementTime == 0 || annoucementBairro == "" || annoucementCategory == ""{
            return "Preencha todos os campos."
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


