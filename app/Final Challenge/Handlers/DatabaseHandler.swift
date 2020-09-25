//
//  DatabaseHandler.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 09/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class DatabaseHandler {
    
    //Login function using Firebase, with email and password
    static func loginWithEmail(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else{
                //Show error during login
                return completion(.failure(error!))
            }
            completion(.success(""))
        }
    }
    
    //Create account using email in Firebase
    static func signUpWithEmail(email: String, password: String, adress: String, fullname: String, bio: String, facebook: String, site: String, storeName: String, imageData: Data, completion: @escaping (Result<String,Error>) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                // There was an error while creating user
                return completion(.failure(error))
            } else {
                // User created sucessfully
                // Upload User Profile Picture
                let storage = Storage.storage(url: HardConstants.Database.storageURL)
                let storageReference = storage.reference()
                let profileImageReference = storageReference.child("profilePictures/\(result!.user.uid)")
                let profileImageData = imageData
                
                let uploadTask = profileImageReference.putData(profileImageData, metadata: nil) { (metadata, error) in
                    guard error == nil else {
                        //Show Error while uploading image
                        return completion(.failure(error!))
                    }
                    profileImageReference.downloadURL { (url, error) in
                        if error != nil {
                            //Show error while downloading image
                            return completion(.failure(error!))
                        }
                        if let url = url {
                            let database = Firestore.firestore()
                            database.collection("users").addDocument(data:
                                ["full_name":fullname,
                                 "store_name":storeName,
                                 "adress":adress,
                                 "bio":bio,
                                 "site":site,
                                 "facebook":facebook,
                                 "email": email,
                                 "uid":result!.user.uid,
                                 "profile_image_url":url.absoluteString]) { (error) in
                                    if error != nil {
                                        // Show error message
                                    }
                                    
                            }
                        }
                    }
                }
                uploadTask.resume()
                completion(.success("User created sucessfully."))
            }
        }
    }
    
    static func createAnnoucement(annoucementName: String, annoucementDescription: String, annoucementLocation: String, deliveryOption: Bool, productType: String, completion: @escaping (Result<String,Error>) -> Void){
        let database = Firestore.firestore()
        guard let userAuth = FirebaseAuth.Auth.auth().currentUser else { return }
        let annoucementDocument = database.collection("annoucements").document()
        let storage = Storage.storage(url: HardConstants.Database.storageURL)
        let storageReference = storage.reference()
        let annoucementImageReference = storageReference.child("annoucementPictures/\(annoucementDocument.documentID)")
        let annoucementImageData = Data()
        let uploadTask = annoucementImageReference.putData(annoucementImageData, metadata: nil) { (metadata, error) in
            guard error == nil else {
                return completion(.failure(error!))
                //Show error wihle uploading annoucement Image
            }
            annoucementImageReference.downloadURL { (url, error) in
                guard error == nil else {
                    return completion(.failure(error!))
                }
                if let url = url {
                    annoucementDocument.setData(["annoucement_name":annoucementName,
                                                 "annoucement_description":annoucementDescription,
                                                 "annoucement_location":annoucementLocation,
                                                 "annoucement_id":annoucementDocument.documentID,
//                                                 "annoucement_image_url":url,
                                                 "delivery_option": deliveryOption,
                                                 "product_type": productType,
                                                 "annoucement_user_id":userAuth.uid]) { (error) in
                                                    if error != nil {
                                                        return completion(.failure(error!))
                                                    }
                                                    completion(.success("Created annoucement sucessfully"))
                    }
                }
            }
        }
        uploadTask.resume()
        completion(.success("Uploaded annoucement sucessfully"))
    }
    
    static func deleteAnnoucement(annoucementID: String, completion: @escaping (Result<String,Error>) -> Void) {
        let database = Firestore.firestore()
        let storageReference = Storage.storage(url: HardConstants.Database.storageURL).reference()
        let annoucementImageReference = storageReference.child("annoucementPictures/\(annoucementID)")
        database.collection("annoucements").document(annoucementID).delete { (error) in
            if error != nil {
                //Show error while deleting file
                completion(.failure(error!))
            }
            annoucementImageReference.delete { (error) in
                if error != nil {
                    //Show error while deleting annoucement picture from storage
                }
            }
            completion(.success("Deleted  annoucement sucessfully."))
        }
    }
    
    static func editAnnoucement(annoucementID: String, annoucementName: String, annoucementLocation: String, annoucementDescription: String, deliveryOption: Bool, productType: String, completion: @escaping (Result<String,Error>) -> Void){
        let database = Firestore.firestore()
        database.collection("annoucements").document(annoucementID).updateData(
            ["annoucement_name":annoucementName,
             "annoucement_location":annoucementLocation,
             "annoucement_description":annoucementDescription,
             "delivery_option":deliveryOption,
             "product_type": productType]) { (error) in
                if error != nil {
                    completion(.failure(error!))
                }
                completion(.success("Uptaded annoucement sucessfully"))
        }
    }
    
    static func readAnnoucements(completion: @escaping (Result<[Annoucement],Error>) -> Void){
        let database = Firestore.firestore()
        var annoucements: [Annoucement] = []
        database.collection("annoucements").getDocuments { (snapshot, error) in
            if error != nil {
                completion(.failure(error!))
            } else {
                guard let snapshot = snapshot else { return }
                for element in snapshot.documents {
                    let data = element.data()
                    guard let annoucementName = data["annoucement_name"] as? String else { return }
                    guard let annoucementID = data["annoucement_id"] as? String else { return }
                    guard let annoucementDescription = data["annoucement_description"] as? String else { return }
                    guard let annoucementLocation = data["annoucement_location"] as? String else { return }
                    guard let annoucementUserID = data["annoucement_user_id"] as? String else { return }
                    guard let deliveryOption = data["delivery_option"] as? Bool else { return }
                    guard let productType = data["product_type"] as? String else { return }
                    let annoucement = Annoucement(annoucementName: annoucementName, userID: annoucementUserID, description: annoucementDescription, annoucementID: annoucementID, location: annoucementLocation, optionDelivery: deliveryOption, productType: productType)
                    annoucements.append(annoucement)
                }
            }
            completion(.success(annoucements))
        }
    }
    
    static func getProfileImage(userID: String, completion: @escaping (Result<Data,Error>) -> Void) {
        let storage = Storage.storage(url: HardConstants.Database.storageURL)
        let storageReference = storage.reference()
        let profileImageReference = storageReference.child("profilePictures/\(userID)")
        profileImageReference.getData(maxSize: 1*1024*1024) { (data, error) in
            if error != nil {
                completion(.failure(error!))
                //Show error message while downloading picture
            } else {
                guard let imageData = data else { return }
                completion(.success(imageData))
            }
        }
    }
    
    static func getUserData(userID: String, completion: @escaping (Result<User,Error>) -> Void){
        let database = Firestore.firestore()
        database.collection("users").document(userID).getDocument { (snapshot, error) in
            guard error == nil else {
                //Show error while loading document
                return completion(.failure(error!))
            }
            guard let snapshot = snapshot else { return }
            guard let data = snapshot.data() else { return }
            guard let storeName = data["store_name"] as? String else { return }
            guard let bio = data["bio"] as? String else { return }
            guard let site = data["site"] as? String else { return }
            guard let facebook = data["facebook"] as? String else { return }
            guard let email = data["email"] as? String else { return }
            guard let userName = data["full_name"] as? String else { return }
            
            let user = User(userName: userName, userEmail: email, userID: userID, userFacebook: facebook, userBio: bio, userSite: site, userStoreName: storeName)
            completion(.success(user))
        }
    }
    
    static func isUserLoggedIn() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        }
        return true
    }
    
    static func getCurrentUser() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    static func signOut() -> Void {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("Error signing out: %@", error)
        }
    }
}



