//
//  HeaderFeedCollectionView.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 28/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import UIKit

class HeaderFeedCollectionView: UICollectionReusableView{
    
    let labelHeader: UILabel = {
        let label = UILabel()
        label.text = "AAA"
        label.font = UIFont.systemFont(ofSize: 16)
        label.frame.size.height = 20
        label.frame.size.width = 60
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
        labelHeader.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        labelHeader.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        labelHeader.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        labelHeader.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true
    }
}
