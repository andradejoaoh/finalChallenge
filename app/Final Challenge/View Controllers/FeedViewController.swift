//
//  FeedViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CollectionViewCellDelegate, WaterfallLayoutDelegate {
    
    var comeFromPaid: Bool = false
    var selectedAnnoucement:Int?
    

    var annoucements: [Annoucement] = []{
        didSet{
            feedCollectionView.reloadData()
        }
    }

    
    let feedCollectionView: UICollectionView = {
        let layout = WaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8.0
        layout.headerHeight = 20.0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let imageAnnoucements: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "placeholder1"))
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureRefreshControl()
        DatabaseHandler.readAnnoucements { (result) in
            switch result {
            case let .failure(error):
                //Show error while updating feed
                print(error)
            case let .success(annoucements):
                self.annoucements = annoucements
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.comeFromPaid = false
        
    }
    
    func setupViews(){
        
        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self
        view.addSubview(feedCollectionView)
        
        feedCollectionView.register(AnnoucementCell.self, forCellWithReuseIdentifier: HardConstants.CollectionView.annoucementCell)
        feedCollectionView.register(PaidAnnoucementSection.self, forCellWithReuseIdentifier: HardConstants.CollectionView.paidAnnouncementCell)
        feedCollectionView.register(HeaderFeedCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HardConstants.CollectionView.headerFeedView)
        
        
        
        feedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        feedCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        feedCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        feedCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        feedCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        feedCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        feedCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        
        let layout = WaterfallLayout()
        layout.delegate = self
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.headerHeight = 50.0
        feedCollectionView.collectionViewLayout = layout
    }
  
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {//ANNOUCEMENT
            return annoucements.count
        } else {//PAID
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {//ANNOUCEMENT
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.annoucementCell, for: indexPath) as? AnnoucementCell else { return UICollectionViewCell()}
            cell.layer.cornerRadius = 10
            let annoucement = annoucements[indexPath.item]
            
            annoucement.didLoadImage = { [weak cell, weak self] imageData in
                cell?.imageAnnoucement.image = UIImage(data: annoucement.imageData ?? Data())
                cell?.activityIndicator.stopAnimating()
                self?.feedCollectionView.reloadItems(at: [indexPath])
                
            }
            return cell
        } else {//PAID
            guard let paidCell = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.paidAnnouncementCell, for: indexPath) as? PaidAnnoucementSection else { return UICollectionViewCell()}
            paidCell.delegate = self
            
            return paidCell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedAnnoucement = indexPath.item
            performSegue(withIdentifier: HardConstants.Storyboard.annoucementSegue, sender: self)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {//PAID
            return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height)*0.3)
        } else {
            guard let annoucementImage = UIImage(data: annoucements[indexPath.item].imageData ?? Data()) else {
                return CGSize(width: 200, height: 200)
            }
            return CGSize(width: (annoucementImage.size.width), height: (annoucementImage.size.height))
        }
    }
    
    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {
        if section == 0{
            return .flow(column: 1)
        } else {
            return .waterfall(column: 2, distributionMethod: .balanced)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HardConstants.CollectionView.headerFeedView, for: indexPath) as! HeaderFeedCollectionView
            switch indexPath.section{
            case 0:
                headerView.labelHeader.text = "Anúncios em destaque:"
            case 1:
                headerView.labelHeader.text = "Anúncios"
            default:
                headerView.labelHeader.text = "Header Unknown"
            }
            return headerView
        default:
            preconditionFailure("Invalid supplementary view type for this collection view")
        }
        
    }
    
    func collectionViewCell(_ annoucementNumber: Int) {
        self.selectedAnnoucement = annoucementNumber
        self.comeFromPaid = true
        performSegue(withIdentifier: HardConstants.Storyboard.annoucementSegue, sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let annoucementViewController = segue.destination as? AnnoucementViewController {
            if comeFromPaid{
                annoucementViewController.annoucement = annoucements[selectedAnnoucement ?? 0]
                //TODO - mudar para paid annoucements
            } else {
                annoucementViewController.annoucement = annoucements[selectedAnnoucement ?? 0]
            }
            
        }
    }
    
    
    func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
       feedCollectionView.refreshControl = UIRefreshControl()
       feedCollectionView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
       // Update your content…
        DatabaseHandler.readAnnoucements(completion: { (result) in
            switch result {
            case let .failure(error):
                //Show error while updating feed
                print(error)
            case let .success(annoucements):
                self.annoucements = annoucements
                self.feedCollectionView.reloadData()
            }
        })
       // Dismiss the refresh control.
       DispatchQueue.main.async {
          self.feedCollectionView.refreshControl?.endRefreshing()
       }
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
