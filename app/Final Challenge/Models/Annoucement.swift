//
//  Annoucement.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
class Annoucement: Codable {
    let annoucementName: String
    var imageData: Data?
    let userID: String
    let description: String
    let annoucementID: String
    let location: String
    let optionDelivery: Bool
    let productType: String
//    let expirationDate: String
    
    enum CodingKeys: String, CodingKey {
        case annoucementName = "annoucement_name"
        case imageData = "annoucement_image_url"
        case userID = "annoucement_user_id"
        case description = "annoucement_description"
        case annoucementID = "annoucement_id"
        case location = "annoucement_location"
        case optionDelivery = "delivery_option"
        case productType = "product_type"
    }
}
