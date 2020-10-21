//
//  User.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 21/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
class User: Codable {
    let userName: String
    let userEmail: String
    let userID: String
    let userFacebook: String?
    let userBio: String
    let userSite: String?
    let userStoreName: String
    let userPhone: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "full_name"
        case userEmail = "email"
        case userID = "uid"
        case userFacebook = "facebook"
        case userBio = "bio"
        case userSite = "site"
        case userPhone = "phone"
        case userStoreName = "store_name"
    }
}
