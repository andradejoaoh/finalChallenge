//
//  PaidAnnoucementCell.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 13/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit
final class PaidAnnoucementCell: UICollectionViewCell {
    
    
    let imageAnnoucement: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "placeholder1"))
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override init (frame: CGRect){
        super.init(frame: frame)
        setupCell()
    }
    
    func setupCell() {
        addSubview(activityIndicator)
        activityIndicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        activityIndicator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        activityIndicator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        addSubview(imageAnnoucement)
        imageAnnoucement.translatesAutoresizingMaskIntoConstraints = false
        imageAnnoucement.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageAnnoucement.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        imageAnnoucement.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        imageAnnoucement.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            
        self.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        self.imageAnnoucement.image = nil
    }
}
