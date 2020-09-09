//
//  CreatAnnoucementViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore

class CreateAnnoucementViewController: UIViewController{
    @IBOutlet weak var announceButton: UIButton!
    @IBOutlet weak var annoucementNameTextField: UITextField!
    @IBOutlet weak var annoucementDescriptionTextField: UITextField!
    @IBOutlet weak var annoucementLocationTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func annouceAction(_ sender: Any) {
        if validateFields() != nil {
            //Show fill all fields error
        } else {
            
            let database = Firestore.firestore()
            let annoucementName = annoucementNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let annoucementDescription = annoucementDescriptionTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let annoucementLocation = annoucementLocationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            guard let userAuth = FirebaseAuth.Auth.auth().currentUser else { return }
            let annoucementDocument = database.collection("annoucements").document()
            
            annoucementDocument.setData(["annoucement_name":annoucementName,
                                         "annoucement_description":annoucementDescription,
                                         "annoucement_location":annoucementLocation,
                                         "annoucement_id":annoucementDocument.documentID,
                                         "annoucement_user_id":userAuth.uid]) { (error) in
                if error != nil {
                    //Show error message
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
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
}
