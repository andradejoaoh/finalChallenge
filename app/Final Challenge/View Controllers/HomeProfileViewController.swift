//
//  ViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 31/08/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class HomeProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if DatabaseHandler.isUserLoggedIn() {
            transitionToProfile()
        }
    }
    
    
    func transitionToProfile(){
        let profileViewController = storyboard?.instantiateViewController(identifier: HardConstants.Storyboard.profileViewController) as? ProfileViewController
        view.window?.rootViewController = profileViewController
        view.window?.makeKeyAndVisible()
    }
}

