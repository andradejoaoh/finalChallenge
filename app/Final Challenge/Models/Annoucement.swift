//
//  Annoucement.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
struct Annoucement: Codable {
    let imageURL: String
    let userID: String
    let description: String
    let annoucementID: String
    let location: String
    let optionDelivery: Bool
    let productType: String
    let userContact: String
    let expirationDate: String
}
