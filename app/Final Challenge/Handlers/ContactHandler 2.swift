//
//  ContactHandler.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 16/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit
class ContactHandler {
    static func createContactController(to user: User) -> UIAlertController {
        let actionSheet = UIAlertController(title: "Entrar em Contato", message: "Como deseja entrar em contato?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Telefonar", style: .default, handler: { (UIAlertAction) in
            if let url = URL(string: "tel://\(String(describing: user.userPhone))"), UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Mandar um e-mail", style: .default, handler: { (UIAlertAction) in
            if let url = URL(string: "mailto:\(String(describing: user.userEmail))"){
                if #available(iOS 10.0, *){
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                    
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        return actionSheet
    }
}
