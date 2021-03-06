//
//  HeaderPerfilCollectionView.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 09/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//


import UIKit

class HeaderPerfilCollectionView: UICollectionReusableView{
    
    let labelHeader: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16)
        label.frame.size.height = 10
//        label.frame.size.width = 60
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setup(){
        addSubview(labelHeader)
        labelHeader.translatesAutoresizingMaskIntoConstraints = false
        labelHeader.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        labelHeader.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }
}

