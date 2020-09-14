//
//  ViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 31/08/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class HomeProfileViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupStyleElements()
        if DatabaseHandler.isUserLoggedIn() {
            transitionToProfile()
        }
    }

    func setupStyleElements(){
        StyleElements.styleFilledButton(loginButton)
        StyleElements.styleFilledButton(signUpButton)
    }
    
    
    func transitionToProfile(){
        let profileViewController = storyboard?.instantiateViewController(identifier: HardConstants.Storyboard.profileViewController) as? ProfileViewController
        view.window?.rootViewController = profileViewController
        view.window?.makeKeyAndVisible()
    }
}

