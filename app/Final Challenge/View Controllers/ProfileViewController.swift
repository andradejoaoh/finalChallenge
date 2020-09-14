//
//  HomeViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 03/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func getProfileImage() {
        let storage = Storage.storage(url: HardConstants.Database.storageURL)
        let storageReference = storage.reference()
        guard let user = Auth.auth().currentUser else { return }
        let profileImageReference = storageReference.child("profilePictures/\(user.uid)")
        var imageData: UIImage?
        profileImageReference.getData(maxSize: 1*1024*1024) { (data, error) in
            if error != nil {
                print(error)
                //Show error message while downloading picture
            } else {
                imageData = UIImage(data: data!)
                self.profileImageView.image = imageData
            }
        }
    }
    

    @IBAction func signOutAction(_ sender: Any) {
        DatabaseHandler.signOut()
        navigationController?.popViewController(animated: true)
    }    
}
