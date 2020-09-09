//
//  EditAnnoucementViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 09/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseCore

class EditAnnoucementViewController: UIViewController {
    var annoucement: Annoucement?
    let database = Firestore.firestore()
    
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
        database.collection("annoucements").document(annoucement.annoucementID).delete { (error) in
            if error != nil {
                //Show error while deleting file
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
        guard let annoucement = annoucement else { return }
        
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let description = descriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let location = locationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        database.collection("annoucements").document(annoucement.annoucementID).updateData(
            ["annoucement_name":name,
             "annoucement_location":location,
             "annoucement_description":description]) { (error) in
                if error != nil {
                    //Show error while updating annoucement
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
        }
    }
}
