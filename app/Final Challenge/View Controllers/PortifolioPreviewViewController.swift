//
//  PortifolioPreviewViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 27/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class PortifolioPreviewViewController: UIViewController {
    
    let portifolioImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = .zero
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    convenience init(portifolio image: UIImage) {
        self.init(nibName: nil, bundle: nil)
        self.portifolioImage.image = image
    }
    
    func setupView(){
        self.view.addSubview(portifolioImage)
        portifolioImage.translatesAutoresizingMaskIntoConstraints = false
        portifolioImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        portifolioImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        portifolioImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        portifolioImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
    }
}
