//
//  FeedViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    //annoucementCell
    
    @IBOutlet weak var announcementsCollectionView: UICollectionView!
    //otherAnnouncementCell
    
    var annoucements: [Annoucement] = []{
        didSet{
            feedCollectionView.reloadData()
        }
    }
    
    var selectedAnnoucement:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return annoucements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.annoucementCell, for: indexPath) as? AnnoucementCell else { return UICollectionViewCell()}
        
        cell.backgroundColor = .red
        cell.annoucementNameLabel.text = annoucements[indexPath.item].annoucementName
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAnnoucement = indexPath.item
        performSegue(withIdentifier: HardConstants.Storyboard.editSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editViewController = segue.destination as? EditAnnoucementViewController {
            editViewController.annoucement = annoucements[selectedAnnoucement ?? 0]
        }
    }
    
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 12)/2, height: collectionView.frame.height/4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        12
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



