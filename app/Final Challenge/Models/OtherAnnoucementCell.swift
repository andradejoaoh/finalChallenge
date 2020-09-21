//
//  OtherAnnoucementCell.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 15/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class OtherAnnoucementCell: UICollectionViewCell {
   
    @IBOutlet weak var otherAnnoucementImages: UIImageView!
    @IBOutlet weak var otherAnnouncementNameLabel: UILabel!
    var img = UIImage(named: "placeholder")
    
    override func layoutSubviews() {
        //otherAnnoucementImages = UIImageView(image: img)
        //img = UIImage(named: "placeholder")!
        super.layoutSubviews()
    }
    
    
}
