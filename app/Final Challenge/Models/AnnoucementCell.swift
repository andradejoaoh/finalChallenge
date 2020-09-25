//
//  AnnoucementCell.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class AnnoucementCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    @IBOutlet weak var annoucementNameLabel: UILabel!
//    @IBOutlet weak var annoucementImages: UIImageView!
    
    var annoucements: [Annoucement] = []{
        didSet{
            annoucementCollectionView.reloadData()
        }
    }
    override init (frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .red
        
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var feedViewController = FeedViewController()

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
        annoucementCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
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
        
        //annoucementCollectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        //annoucementCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        annoucementCollectionView.register(annoucementCellForSection.self, forCellWithReuseIdentifier: HardConstants.CollectionView.annoucementCellSection)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(annoucements.count)
        
        return annoucements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.annoucementCellSection, for: indexPath) as? annoucementCellForSection else { return UICollectionViewCell()}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width/2.5), height: (frame.height))
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
