//
//  FeedViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //@IBOutlet weak var feedCollectionView: UICollectionView!
    //annoucementCell
    
    let feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    func setup(){
        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self
        view.addSubview(feedCollectionView)
        
        feedCollectionView.register(AnnoucementCell.self, forCellWithReuseIdentifier: HardConstants.CollectionView.annoucementCell)
        feedCollectionView.register(PaidAnnoucementCell.self, forCellWithReuseIdentifier: HardConstants.CollectionView.paidAnnouncementCell)
        
        feedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        feedCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        feedCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        feedCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        feedCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        feedCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        feedCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    
    
    var annoucements: [Annoucement] = []{
        didSet{
            feedCollectionView.reloadData()
        }
    }
    
    var selectedAnnoucement:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {//ANNOUCEMENT
            return annoucements.count
        } else {//PAID
            return annoucements.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {//ANNOUCEMENT
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.annoucementCell, for: indexPath) as? AnnoucementCell else { return UICollectionViewCell()}
            //cell.backgroundColor = .red
            //cell.annoucementNameLabel.text = annoucements[indexPath.item].annoucementName
            return cell
        } else {
            guard let paidCell = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.paidAnnouncementCell, for: indexPath) as? PaidAnnoucementCell else { return UICollectionViewCell()}
            //paidCell.backgroundColor = .blue
            return paidCell
        }
        
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAnnoucement = indexPath.item
        performSegue(withIdentifier: HardConstants.Storyboard.annoucementSegue, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->  CGSize{
        
        if indexPath.section == 1{//ANNOUNCEMENT
            return CGSize(width:  (view.frame.width/2.5), height: 100)
        } else {//PAID
            return CGSize(width:  (view.frame.width/2.5), height: 225)
        }
        
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1{//ANNOUCEMENT
            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        } else {//PAID
            return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let annoucementViewController = segue.destination as? AnnoucementViewController {
            annoucementViewController.annoucement = annoucements[selectedAnnoucement ?? 0]
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





// PINTEREST CELL
//        if indexPath.section == 1 {
//            let numberOfColumns: CGFloat =  2
//            let width = collectionView.frame.size.width
//            let xInsets: CGFloat = 10
//            let cellSpacing: CGFloat = 5
//            return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: (width/numberOfColumns) - (xInsets + cellSpacing))
//        } else {
//            return CGSize(width: (collectionView.frame.width/2), height: (collectionView.frame.height/3))
//        }
//        return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height))





//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        0
//    }
//}
