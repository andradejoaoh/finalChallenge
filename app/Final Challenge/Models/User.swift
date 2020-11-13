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
    let userCategory: String
    let userAddress: String
    let userNumberAddress: String
    let userInstagram: String?
    let userTelegram: String?
    let userCheckLocation: Bool
    let userCheckTelefone: Bool
    let userCEP: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "full_name"
        case userEmail = "email"
        case userID = "uid"
        case userFacebook = "facebook"
        case userBio = "bio"
        case userSite = "site"
        case userPhone = "phone"
        case userStoreName = "store_name"
        case userCategory = "category"
        case userAddress = "address"
        case userNumberAddress = "addressNumber"
        case userInstagram = "instagram"
        case userTelegram = "telegram"
        case userCheckLocation = "checkLocation"
        case userCheckTelefone = "checkTelefone"
        case userCEP = "CEP"
    }
}
