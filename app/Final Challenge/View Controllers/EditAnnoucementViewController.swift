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
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let annoucement = annoucement {
            nameTextField.text = annoucement.annoucementName
            descriptionTextField.text = annoucement.description
            locationTextField.text = annoucement.location
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        guard let annoucement = annoucement else { return }
        DatabaseHandler.deleteAnnoucement(annoucementID: annoucement.annoucementID) { (result) in
            switch result {
            case let .failure(error):
                //Error while deleting annoucement
                print(error)
            case .success:
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
        guard let annoucement = annoucement else { return }
        
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let description = descriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let location = locationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        DatabaseHandler.editAnnoucement(annoucementID: annoucement.annoucementID, annoucementName: name, annoucementLocation: location, annoucementDescription: description) { (result) in
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
