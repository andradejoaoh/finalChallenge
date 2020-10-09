//
//  AnnoucementPortifolioCell.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 09/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//


import UIKit

class AnnoucementPortifolioCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    weak var delegate: CollectionViewCellDelegate?
    
    var annoucements: [Annoucement] = []{
        didSet{
            portifolioCollectionView.reloadData()
        }
    }
    
    var imageLiteralArray = [#imageLiteral(resourceName: "placeholder1"), #imageLiteral(resourceName: "placeholder2"), #imageLiteral(resourceName: "placeholder3"), #imageLiteral(resourceName: "placeholder4"), #imageLiteral(resourceName: "placeholder1"), #imageLiteral(resourceName: "placeholder2"), #imageLiteral(resourceName: "placeholder3"), #imageLiteral(resourceName: "placeholder4"), #imageLiteral(resourceName: "placeholder1")]
    
    
    var imagesPortifolio: [String]? {
        didSet{
            portifolioCollectionView.reloadData()
        }
    }
    
    //var selectedAnnoucement:Int?
    
    override init (frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let portifolioCollectionView: UICollectionView = {
        let annoucemnetLayout = UICollectionViewFlowLayout()
        annoucemnetLayout.minimumLineSpacing = 10
        annoucemnetLayout.scrollDirection = .horizontal
        let announcementCV = UICollectionView(frame: .zero, collectionViewLayout: annoucemnetLayout)
        announcementCV.backgroundColor = .clear
        return announcementCV
    }()
    
    
    
    func setup(){
        addSubview(portifolioCollectionView)
        
        portifolioCollectionView.delegate = self
        portifolioCollectionView.dataSource = self
        
        portifolioCollectionView.translatesAutoresizingMaskIntoConstraints = false
        portifolioCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        portifolioCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        portifolioCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        portifolioCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        
        
        
        DatabaseHandler.readAnnoucements { (result) in
            switch result {
            case let .failure(error):
                //Show error while updating feed
                print(error)
            case let .success(annoucements):
                self.annoucements = annoucements
            }
        }
        portifolioCollectionView.register(annoucementPortifoliiCellForSection.self, forCellWithReuseIdentifier: HardConstants.CollectionView.annoucementPortifolioCellSection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return annoucements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.annoucementPortifolioCellSection, for: indexPath) as? annoucementPortifoliiCellForSection else { return UICollectionViewCell()}
        
        let imageName = imageLiteralArray[indexPath.item]
        cell.imagePortifolioAnnoucements.image = imageName
        
        cell.layer.cornerRadius = 10
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.collectionViewCell(indexPath.item)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width)*0.3, height: (frame.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private class annoucementPortifoliiCellForSection: UICollectionViewCell {
        
        
        let imagePortifolioAnnoucements: UIImageView = {
            let image = UIImageView(image: #imageLiteral(resourceName: "placeholder1"))
            image.layer.cornerRadius = 10
            image.clipsToBounds = true
            image.contentMode = .scaleAspectFill
            return image
        }()
        
        override init (frame: CGRect){
            super.init(frame: frame)
            setupCell()
        }
        
        func setupCell() {
            
            addSubview(imagePortifolioAnnoucements)

            imagePortifolioAnnoucements.translatesAutoresizingMaskIntoConstraints = false
            imagePortifolioAnnoucements.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            imagePortifolioAnnoucements.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            imagePortifolioAnnoucements.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            imagePortifolioAnnoucements.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


