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
        image.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
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
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Descrição - Lorem ipsum dolor sit amet. Ut autem dolores ea quia omnis eos eveniet facilis in possimus dicta"
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    let contactButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        button.setTitle("Contato", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
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
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.frame.size.width = 103
        button.frame.size.height = 30
        button.layer.cornerRadius = 15
        return button
    }()
    
    let redesSociaisButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        button.setTitle("Redes Sociais", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.frame.size.width = 103
        button.frame.size.height = 30
        button.layer.cornerRadius = 15
        return button
    }()
    
    let createAnnoucementButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        button.setTitle("Criar Anúncio", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
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
        addSubview(perfilNameLabel)
        addSubview(categoryLabel)
        addSubview(bairroLabel)

        addSubview(descriptionLabel)
        addSubview(contactButton)
        addSubview(siteButton)
        addSubview(redesSociaisButton)
        addSubview(createAnnoucementButton)
        
        
        imagePerfil.translatesAutoresizingMaskIntoConstraints = false
        imagePerfil.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imagePerfil.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        imagePerfil.heightAnchor.constraint(equalToConstant: CGFloat(52)).isActive = true
        imagePerfil.widthAnchor.constraint(equalToConstant: CGFloat(52)).isActive = true
        
        perfilNameLabel.translatesAutoresizingMaskIntoConstraints = false
        perfilNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        perfilNameLabel.leftAnchor.constraint(equalTo: self.imagePerfil.rightAnchor, constant: 10).isActive = true
        perfilNameLabel.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.topAnchor.constraint(equalTo: self.perfilNameLabel.bottomAnchor, constant: 0).isActive = true
        categoryLabel.leftAnchor.constraint(equalTo: self.imagePerfil.rightAnchor, constant: 10).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        
        bairroLabel.translatesAutoresizingMaskIntoConstraints = false
        bairroLabel.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 0).isActive = true
        bairroLabel.leftAnchor.constraint(equalTo: self.imagePerfil.rightAnchor, constant: 10).isActive = true
        bairroLabel.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        contactButton.topAnchor.constraint(equalTo: self.imagePerfil.bottomAnchor, constant: 18).isActive = true
        contactButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        contactButton.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        contactButton.widthAnchor.constraint(equalToConstant: self.contentView.frame.width/3 * 0.95).isActive = true
        
        siteButton.translatesAutoresizingMaskIntoConstraints = false
        siteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        siteButton.topAnchor.constraint(equalTo: self.imagePerfil.bottomAnchor, constant: 18).isActive = true
        siteButton.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        siteButton.widthAnchor.constraint(equalToConstant: self.contentView.frame.width/3 * 0.95).isActive = true
        
        redesSociaisButton.translatesAutoresizingMaskIntoConstraints = false
        redesSociaisButton.topAnchor.constraint(equalTo: self.imagePerfil.bottomAnchor, constant: 18).isActive = true
        redesSociaisButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        redesSociaisButton.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        redesSociaisButton.widthAnchor.constraint(equalToConstant: self.contentView.frame.width/3 * 0.95).isActive = true
        
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: self.siteButton.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: CGFloat(self.contentView.frame.size.width)).isActive = true
        
        
        createAnnoucementButton.translatesAutoresizingMaskIntoConstraints = false
        createAnnoucementButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        createAnnoucementButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        createAnnoucementButton.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        createAnnoucementButton.widthAnchor.constraint(equalToConstant: CGFloat(self.contentView.frame.size.width * 0.97)).isActive = true
        
        //createAnnoucementButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
       

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


