//
//  AnnoucementCell.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class AnnoucementCell: UICollectionViewCell{
    
    let imageAnnoucements: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "placeholder1"))
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init (frame: CGRect){
        super.init(frame: frame)
        setupView()
        //backgroundColor = .blue
    }
    func setupView(){
        addSubview(imageAnnoucements)
        
        imageAnnoucements.translatesAutoresizingMaskIntoConstraints = false
        imageAnnoucements.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageAnnoucements.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        imageAnnoucements.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        imageAnnoucements.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
