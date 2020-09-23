//
//  HomeViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 03/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var userProfile: User?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bio: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
    }

    @IBAction func signOutAction(_ sender: Any) {
        DatabaseHandler.signOut()
        if let homeProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: HardConstants.Storyboard.homeProfileViewController), let navigationController = self.navigationController{
            navigationController.setViewControllers([homeProfileViewController], animated: true)
        }
    }
    
    func setupView() {
        if let user = self.userProfile {
            DatabaseHandler.getProfileImage(userID: user.userID) { result in
                switch result {
                case let .success(data):
                    self.profileImageView.image = UIImage(data: data)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}
