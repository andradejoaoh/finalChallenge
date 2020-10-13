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
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var annouceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
    }

    @IBAction func signOutAction(_ sender: Any) {
        let signOutAlert = UIAlertController(title: "Deseja Sair?", message: "Você poderá fazer login quando quiser novamente", preferredStyle: .alert)
        signOutAlert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        signOutAlert.addAction(UIAlertAction(title: "Sair", style: .destructive, handler: { (UIAlertAction) in
            DatabaseHandler.signOut()
            if let homeProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: HardConstants.Storyboard.homeProfileViewController), let navigationController = self.navigationController{
                navigationController.setViewControllers([homeProfileViewController], animated: true)
            }
        }))
        self.present(signOutAlert, animated: true, completion: nil)
    }
    
    @IBAction func contactAction(_ sender: Any){
        
    }
    
    func setupView() {
        if let user = self.userProfile {
            
            bio.text = user.userBio
            
            if user.userID != DatabaseHandler.getCurrentUser() {
                signOutButton.isHidden = true
                annouceButton.isHidden = true
            } else {
                signOutButton.isHidden = false
                annouceButton.isHidden = false
            }
            
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
    
    func createAlertController() -> UIAlertController {
        let actionSheet = UIAlertController(title: "Entrar em Contato", message: "Como deseja entrar em contato?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Telefonar", style: .default, handler: { (UIAlertAction) in
            if let url = URL(string: "tel://\(String(describing: self.userProfile?.userPhone))"), UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Mandar um e-mail", style: .default, handler: { (UIAlertAction) in
            if let url = URL(string: "mailto:\(self.userProfile?.userEmail)"){
                if #available(iOS 10.0, *){
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)

                }
            }
        }))
        return actionSheet
    }
}
