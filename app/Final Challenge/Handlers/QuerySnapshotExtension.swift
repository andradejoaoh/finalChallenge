//
//  QuerySnapshotExtension.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 01/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

extension QuerySnapshot {
    
    func toObject<T: Decodable>() throws -> [T] {
        let objects: [T] = try documents.map({ try $0.toObject() })
        return objects
    }
}

extension QueryDocumentSnapshot {
    func toObject<T: Decodable>() throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
        let object = try JSONDecoder().decode(T.self, from: jsonData)
        
        return object
    }
}

