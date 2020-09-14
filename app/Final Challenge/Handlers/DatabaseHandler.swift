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
    
    //Login function using Firebase
    static func loginWithEmail(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else{
                return completion(.failure(error!))
            }
            completion(.success(""))
        }
    }
    
    //Create account using email in Firebase
    static func signUpWithEmail(email: String, password: String, adress: String, fullname: String, imageData: Data, completion: @escaping (Result<String,Error>) -> Void){
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
                                 "adress":adress,
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
    
    static func createAnnoucement(annoucementName: String, annoucementDescription: String, annoucementLocation: String, completion: @escaping (Result<String,Error>) -> Void){
        let database = Firestore.firestore()
        guard let userAuth = FirebaseAuth.Auth.auth().currentUser else { return }
        let annoucementDocument = database.collection("annoucements").document()
        
        annoucementDocument.setData(["annoucement_name":annoucementName,
                                     "annoucement_description":annoucementDescription,
                                     "annoucement_location":annoucementLocation,
                                     "annoucement_id":annoucementDocument.documentID,
                                     "annoucement_user_id":userAuth.uid]) { (error) in
                                        if error != nil {
                                            return completion(.failure(error!))
                                        }
                                        completion(.success("Created annoucement sucessfully"))
        }
    }
    
    static func deleteAnnoucement(annoucementID: String, completion: @escaping (Result<String,Error>) -> Void) {
        let database = Firestore.firestore()
        database.collection("annoucements").document(annoucementID).delete { (error) in
            if error != nil {
                //Show error while deleting file
                completion(.failure(error!))
            }
            completion(.success("Deleted  annoucement sucessfully."))
        }
    }
    
    static func editAnnoucement(annoucementID: String, annoucementName: String, annoucementLocation: String, annoucementDescription: String, completion: @escaping (Result<String,Error>) -> Void){
        let database = Firestore.firestore()
        database.collection("annoucements").document(annoucementID).updateData(
            ["annoucement_name":annoucementName,
             "annoucement_location":annoucementLocation,
             "annoucement_description":annoucementDescription]) { (error) in
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
                    let annoucement = Annoucement(annoucementName: annoucementName, userID: annoucementUserID, description: annoucementDescription, annoucementID: annoucementID, location: annoucementLocation)
                    annoucements.append(annoucement)
                }
            }
            completion(.success(annoucements))
        }
    }
}



