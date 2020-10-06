//
//  AnnoucementDetailTableViewCell.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 06/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class AnnoucementDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var imagesCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
