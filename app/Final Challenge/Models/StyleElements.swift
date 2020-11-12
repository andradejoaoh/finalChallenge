//
//  StyleElements.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 11/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import UIKit

class StyleElements {
    
    static func styleTextField(_ textfield: UITextField){
        //create bottom line
//        let bottomLine = CALayer()
//
//        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width*0.75, height: 2)
//
//        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
//
//        //remove border on textfield
//        textfield.borderStyle = .none
//
//        //add the line to the text field
//        textfield.layer.addSublayer(bottomLine)
        textfield.layer.cornerRadius = 10
    }
    
    static func styleFilledButton(_ button: UIButton){
        //filled rounded cornor style
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button: UIButton){
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
}
