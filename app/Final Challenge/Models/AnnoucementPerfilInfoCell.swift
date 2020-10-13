//
//  AnnoucementPerfilInfoCell.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 09/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class AnnoucementPerfilInfoCell: UICollectionViewCell{
    
    
    let imagePerfil: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "placeholder3"))
        image.frame.size.width = 52
        image.frame.size.height = 52
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let perfilNameLabel: UILabel = {
        let perfilNameLabel = UILabel()
        perfilNameLabel.text = "Nome do perfil placeholder"
        perfilNameLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
        perfilNameLabel.textColor = .black
        return perfilNameLabel
    }()
    
    let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.text = "Categoria placeholder"
        categoryLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        categoryLabel.textColor = .black
        return categoryLabel
    }()
    
    let bairroLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.text = "Bairro placeholder"
        categoryLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        categoryLabel.textColor = .black
        return categoryLabel
    }()
    
    let descriptionLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.text = "Descrição - Lorem ipsum dolor sit amet. Ut autem dolores ea quia omnis eos eveniet facilis in possimus dicta"
        categoryLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        categoryLabel.textColor = .black
        return categoryLabel
    }()
    
    let contactButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        button.setTitle("Contato", for: .normal)
        button.frame.size.width = 103
        button.frame.size.height = 30
        button.layer.cornerRadius = 15
        return button
    }()
    //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    
    let siteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        button.setTitle("Site", for: .normal)
        button.frame.size.width = 103
        button.frame.size.height = 30
        button.layer.cornerRadius = 15
        return button
    }()
    
    let redesSociaisButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        button.setTitle("Redes Sociais", for: .normal)
        button.frame.size.width = 103
        button.frame.size.height = 30
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init (frame: CGRect){
        super.init(frame: frame)
        setupView()
        //backgroundColor = .blue
    }
    func setupView(){
        addSubview(imagePerfil)
//        addSubview(perfilNameLabel)
//        addSubview(categoryLabel)
//        addSubview(bairroLabel)
//
//        addSubview(descriptionLabel)
//        addSubview(contactButton)
//        addSubview(siteButton)
//        addSubview(redesSociaisButton)
        
        
        imagePerfil.translatesAutoresizingMaskIntoConstraints = false
        imagePerfil.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imagePerfil.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        //imagePerfil.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 50).isActive = true
        //imagePerfil.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 50).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


