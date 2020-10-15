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
import Firebase

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
                guard let user = result?.user else { return }
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
                            database.collection("users").document(user.uid).setData(["full_name":fullname,
                                                                                     "store_name":storeName,
                                                                                     "adress":adress,
                                                                                     "bio":bio,
                                                                                     "site":site,
                                                                                     "facebook":facebook,
                                                                                     "email": email,
                                                                                     "uid":result!.user.uid,
                                                                                     "profile_image_url":url.absoluteString]) { (error) in
                                if error != nil {
                                    //Show error while creating user
                                    completion(.failure(error!))
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
    
    static func createAnnoucement(annoucementName: String, annoucementDescription: String, annoucementLocation: String, annoucementImage: Data, deliveryOption: Bool, expirationDate: Date, productType: String, completion: @escaping (Result<String,Error>) -> Void){
        let database = Firestore.firestore()
        guard let userAuth = FirebaseAuth.Auth.auth().currentUser else { return }
        let annoucementDocument = database.collection("annoucements").document()
        let storage = Storage.storage(url: HardConstants.Database.storageURL)
        let storageReference = storage.reference()
        let annoucementImageReference = storageReference.child("annoucementPictures/\(annoucementDocument.documentID)")
        let annoucementImageData = annoucementImage
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        let dateString = dateFormatter.string(from: expirationDate)
        let uploadTask = annoucementImageReference.putData(annoucementImageData, metadata: nil) { (metadata, error) in
            guard error == nil else {
                return completion(.failure(error!))
                //Show error wihle uploading annoucement Image
            }
            annoucementImageReference.downloadURL { (url, error) in
                guard error == nil else {
                    return completion(.failure(error!))
                }
                if url != nil {
                    annoucementDocument.setData(["annoucement_name":annoucementName,
                                                 "annoucement_description":annoucementDescription,
                                                 "annoucement_location":annoucementLocation,
                                                 "annoucement_id":annoucementDocument.documentID,
                                                 "expiration_date": dateString,
                                                 "delivery_option": deliveryOption,
                                                 "product_type": productType,
                                                 "isPaid": false,
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
        database.collection("annoucements").getDocuments { (snapshot, error) in
            if error != nil {
                completion(.failure(error!))
            } else {
                    guard let snapshot = snapshot else { return }
                    guard let annocs: [Annoucement] = try? snapshot.toObject() else { return completion(.failure(ErrorTypes.parseAnnoucementError)) }
                    getUser(for: annocs)
                    getImage(for: annocs)
                completion(.success(annocs))
            }
        }
    }
    
    static func getData(for userID: String, completion: @escaping (Result<User,Error>) -> Void){
        let database = Firestore.firestore()
        database.collection("users").document(userID).getDocument { (snapshot, error) in
            guard error == nil else {
                return completion(.failure(error!))
            }
            let jsonDecoder = JSONDecoder()
            guard let snapshot = snapshot else { return }
            guard let data = snapshot.data() else { return }
            guard let object = try? JSONSerialization.data(withJSONObject: data) else { return }
            guard let user = try? jsonDecoder.decode(User.self, from: object) else { return }
            completion(.success(user))
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
    
    static func getImage(for annoucement: Annoucement){
        let storage = Storage.storage(url: HardConstants.Database.storageURL)
        let storageReference = storage.reference()
        let annoucementImage = storageReference.child("annoucementPictures/\(annoucement.annoucementID)")
        annoucementImage.getData(maxSize: 1*1024*1024) { (data, error) in
            weak var annoucement: Annoucement? = annoucement
            if error != nil {
                //Show error while getting annoucementImage
            } else {
                guard let data = data, let annoucement = annoucement else { return }
                annoucement.imageData = data
            }
        }
    }
    
    static func getImage(for annoucements: [Annoucement]){
        annoucements.forEach(getImage)
    }
    
    static func getUser(for annoucement: Annoucement){
        getData(for: annoucement.userID) { (result) in
            switch result {
            case let .success(user):
                annoucement.user = user
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getUser(for annoucements: [Annoucement]){
        annoucements.forEach(getUser)
    }
    
}

