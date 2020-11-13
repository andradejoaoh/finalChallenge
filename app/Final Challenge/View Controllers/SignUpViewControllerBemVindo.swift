//
//  SignUpViewControllerBemVindo.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 11/11/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import UIKit


class SignUpViewControllerBemVindo: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    


    @IBOutlet weak var avanceButton: UIButton!
    
    @IBOutlet weak var continueCadastroButton: UIButton!
    
    var fullname = String()
    var bio = String()
    var email = String()
    var senha = String()
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupStyleForElements()
        self.hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
   
    
    //style for elements
    func setupStyleForElements(){
        avanceButton.backgroundColor = UIColor(named: "button")
        avanceButton.layer.cornerRadius = 15
        
    }
    
    @IBAction func unwindToBemVindoContent(segue:UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SwipeSegueToImagemPerfil" || segue.identifier == "SegueToImagemPerfil" {
            let destinationController = segue.destination as! SignUpViewControllerImagemPerfil
            destinationController.fullname = fullname
            destinationController.bio = bio
            destinationController.email = email
            destinationController.senha = senha
            destinationController.name = name
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    //hide keyboard function
    
    
 
    
}

