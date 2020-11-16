//
//  Annoucement.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import FirebaseFirestore
class Annoucement: Codable {
    var annoucementName: String
    var imageData: Data? {
        didSet {
            guard let imageData = imageData, let didLoadImage = didLoadImage else { return }
            didLoadImage(imageData)
        }
    }
    let userID: String
    var description: String
    let annoucementID: String
    var location: String
    let expirationDate: Date?
    let isActive: Bool?
    var price: Float?
    var category: String
    var emailCheck: Bool
    var telefoneCheck: Bool
    var user: User?
    
    var lat: Double?
    var long: Double?
    
    var didLoadImage: ((Data) -> Void)? {
        didSet {
            guard let imageData = imageData, let didLoadImage = didLoadImage else { return }
            didLoadImage(imageData)
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        case annoucementName = "annoucement_name"
        case imageData = "annoucement_image_url"
        case userID = "annoucement_user_id"
        case description = "annoucement_description"
        case annoucementID = "annoucement_id"
        case location = "annoucement_location"
        case expirationDate = "expiration_date"
        case user = "user"
        case isActive = "isActive"
        case price = "price"
        case category = "category"
        case emailCheck = "emailCheck"
        case telefoneCheck = "telefoneCheck"
        case lat = "lat"
        case long = "long"
    }
}
