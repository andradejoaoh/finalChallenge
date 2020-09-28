//
//  OtherAnnoucementCell.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 15/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class PaidAnnoucementCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    weak var delegate: CollectionViewCellDelegate?
    
    var annoucements: [Annoucement] = []{
        didSet{
            annoucementCollectionView.reloadData()
        }
    }
    
    var selectedAnnoucement:Int?
    
    override init (frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .red
        
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let annoucementCollectionView: UICollectionView = {
        let annoucemnetLayout = UICollectionViewFlowLayout()
        annoucemnetLayout.minimumLineSpacing = 30
        annoucemnetLayout.scrollDirection = .horizontal
        let announcementCV = UICollectionView(frame: .zero, collectionViewLayout: annoucemnetLayout)
        announcementCV.backgroundColor = .clear
        return announcementCV
    }()
    
    func setup(){
        addSubview(annoucementCollectionView)
        
        annoucementCollectionView.delegate = self
        annoucementCollectionView.dataSource = self
        
        annoucementCollectionView.translatesAutoresizingMaskIntoConstraints = false
        annoucementCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        annoucementCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        annoucementCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        annoucementCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        DatabaseHandler.readAnnoucements { (result) in
            switch result {
            case let .failure(error):
                //Show error while updating feed
                print(error)
            case let .success(annoucements):
                self.annoucements = annoucements
            }
        }
        annoucementCollectionView.register(annoucementCellForSection.self, forCellWithReuseIdentifier: HardConstants.CollectionView.annoucementCellSection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return annoucements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.annoucementCellSection, for: indexPath) as? annoucementCellForSection else { return UICollectionViewCell()}
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.collectionViewCell(indexPath.item)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width/3), height: (frame.height)*0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    private class annoucementCellForSection: UICollectionViewCell {
        override init (frame: CGRect){
            super.init(frame: frame)
            backgroundColor = .green
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


