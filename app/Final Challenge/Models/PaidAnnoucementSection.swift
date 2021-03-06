//
//  OtherAnnoucementCell.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 15/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class PaidAnnoucementSection: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    weak var delegate: CollectionViewCellDelegate?
    
    var annoucements: [Annoucement] = []{
        didSet{
            annoucementCollectionView.reloadData()
        }
    }
    
    
    var placeholderString: String = "placeholder"
    
    var selectedAnnoucement:Int?
    
    override init (frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let annoucementCollectionView: UICollectionView = {
        let annoucemnetLayout = UICollectionViewFlowLayout()
        annoucemnetLayout.minimumLineSpacing = 10
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
        annoucementCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        annoucementCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        annoucementCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        annoucementCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        
        DatabaseHandler.readAnnoucements { (result) in
            switch result {
            case let .failure(error):
                //Show error while updating feed
                print(error)
            case let .success(annoucements):
                self.annoucements = annoucements.filter{ $0.isPaid == true }
            }
        }
        annoucementCollectionView.register(PaidAnnoucementCell.self, forCellWithReuseIdentifier: HardConstants.CollectionView.paidAnnoucementCellSection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return annoucements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.paidAnnoucementCellSection, for: indexPath) as? PaidAnnoucementCell else { return UICollectionViewCell()}
        let annoucement = annoucements[indexPath.item]
        
        annoucement.didLoadImage = { [weak cell] imageData in
            cell?.imageAnnoucement.image = UIImage(data: annoucement.imageData ?? Data())
            cell?.activityIndicator.stopAnimating()
        }
        
        cell.layer.cornerRadius = 10
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.collectionViewCell(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width)*0.6, height: (frame.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


