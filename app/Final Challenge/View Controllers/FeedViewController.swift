//
//  FeedViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseCore
import FirebaseStorage

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    var annoucements: [Annoucement] = []
    var selectedAnnoucement:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let database = Firestore.firestore()
        database.collection("annoucements").getDocuments { (snapshot, error) in
            if error != nil {
                //Show error while getting annoucements
            } else {
                guard let snapshot = snapshot else { return }
                self.annoucements = []
                for element in snapshot.documents {
                    let data = element.data()
                    guard let annoucementName = data["annoucement_name"] as? String else { return }
                    guard let annoucementID = data["annoucement_id"] as? String else { return }
                    guard let annoucementDescription = data["annoucement_description"] as? String else { return }
                    guard let annoucementLocation = data["annoucement_location"] as? String else { return }
                    guard let annoucementUserID = data["annoucement_user_id"] as? String else { return }
                    let annoucement = Annoucement(annoucementName: annoucementName, userID: annoucementUserID, description: annoucementDescription, annoucementID: annoucementID, location: annoucementLocation)
                    self.annoucements.append(annoucement)
                }
            }
            self.feedCollectionView.reloadData()
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
