//
//  HardConstants.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 03/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
struct HardConstants {
    
    struct Storyboard {
        static let profileViewController = "profileViewController"
        static let homeProfileViewController = "homeProfileViewController"
        static let editSegue = "editAnnoucement"
        static let profileSegue = "profileSegue"
        static let annoucementSegue = "showAnnoucement"
    }
    
    struct Database {
        static let storageURL = "gs://macro-f324b.appspot.com"
    }
    
    struct CollectionView {
        static let annoucementCell = "annoucementCell"
        static let otherAnnouncementCell = "otherAnnouncementCell"
    }
    
    struct PickerView {
        static let productType = ["Comida", "Artesanato", "Pintura"]
        static let annoucementTime = ["1 hora", "2 horas", "4 horas", "6 horas", "8 horas", "12 horas", "16 horas", "1 dia", "2 dias"]
    }
    
}
