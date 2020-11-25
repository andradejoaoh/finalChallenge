//
//  User.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 21/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
class User: Codable {
    var imageData: Data?
    var userName: String
    let userEmail: String
    let userID: String
    var userFacebook: String?
    let userBio: String
    var userSite: String?
    var userStoreName: String
    var userPhone: String
    var userCategory: String
    var userAddress: String
    let userNumberAddress: String
    var userInstagram: String?
    var userTelegram: String?
    let userCheckLocation: Bool
    let userCheckTelefone: Bool
    let userCEP: String
    
    enum CodingKeys: String, CodingKey {
        case imageData = "image_data"
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
