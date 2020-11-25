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
    
    static func createSocialController(to user: User) -> UIAlertController {
        if user.userTelegram == "" && user.userInstagram == "" && user.userFacebook == "" {
            let actionSheet = UIAlertController(title: "Redes Sociais Indisponíveis", message: "Usuário não informou suas redes sociais.", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            return actionSheet
        }
        let actionSheet = UIAlertController(title: "Redes Sociais", message: "Escolha a rede social para entrar em contato.", preferredStyle: .actionSheet)
        if user.userTelegram != "" && user.userTelegram != nil {
            actionSheet.addAction(UIAlertAction(title: "Telegram", style: .default, handler: { (UIAlertAction) in
                if let url = URL(string: "\(String(describing: user.userTelegram))"), UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url)
                }
            }))
        }
        if user.userInstagram != "" && user.userInstagram != nil {
            actionSheet.addAction(UIAlertAction(title: "Instagram", style: .default, handler: { (UIAlertAction) in
                if let url = URL(string: "instagram.com/\(String(describing: user.userInstagram))"), UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url)
                }
            }))
        }
        if user.userFacebook != "" && user.userFacebook != nil {
            actionSheet.addAction(UIAlertAction(title: "Facebook", style: .default, handler: { (UIAlertAction) in
                if let url = URL(string: "fb.com/\(String(describing: user.userFacebook))"), UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url)
                }
            }))
        }
        return actionSheet
    }
}
