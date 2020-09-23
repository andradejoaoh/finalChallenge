//
//  FeedViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 08/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    //annoucementCell
    let AnnoucementCellID = "annoucementCell"
    let otherAnnoucementCellID = "otherAnnoucementCell"
    
    
    var annoucements: [Annoucement] = []{
        didSet{
            feedCollectionView.reloadData()
        }
    }
    
    var selectedAnnoucement:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView.register(AnnoucementCell.self, forCellWithReuseIdentifier: AnnoucementCellID)
        feedCollectionView.register(OtherAnnouncementCell.self, forCellWithReuseIdentifier: otherAnnoucementCellID)
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return annoucements.count
        }
        return annoucements.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnnoucementCellID, for: indexPath) as? AnnoucementCell else { return UICollectionViewCell()}
            cell.backgroundColor = .red
            
            
            //cell.annoucementNameLabel.text = annoucements[indexPath.item].annoucementName
            return cell
        }
        guard let otherCell = collectionView.dequeueReusableCell(withReuseIdentifier: otherAnnoucementCellID, for: indexPath) as? OtherAnnouncementCell else { return UICollectionViewCell()}
        otherCell.backgroundColor = .blue
        return otherCell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAnnoucement = indexPath.item
        performSegue(withIdentifier: HardConstants.Storyboard.editSegue, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->  CGSize{
//        if indexPath.section == 1{
//            return CGSize(width: (view.frame.width / 3) - 16, height: 100)
//        }
//        return CGSize(width: (view.frame.width / 2) , height: 200)
        if indexPath.section == 1 {
            let numberOfColumns: CGFloat =  2
            let width = collectionView.frame.size.width
            let xInsets: CGFloat = 10
            let cellSpacing: CGFloat = 5
            return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: (width/numberOfColumns) - (xInsets + cellSpacing))
        } else {
            return CGSize(width: (collectionView.frame.width/2), height: (collectionView.frame.height/3))
        }
        return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1{
            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        }
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editViewController = segue.destination as? EditAnnoucementViewController {
            editViewController.annoucement = annoucements[selectedAnnoucement ?? 0]
        }
    }
    
}








class AnnoucementCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var feedViewControler = FeedViewController()
    var annoucements: [Annoucement] = []{
        didSet{
            feedViewControler.feedCollectionView.reloadData()
        }
    }
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let cellID = "cellId"
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        backgroundColor = .green
        addSubview(collectionView)
        
      // collectionView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CellPrincipalAnnoucements.self, forCellWithReuseIdentifier: cellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return annoucements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CellPrincipalAnnoucements else { return UICollectionViewCell()}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private class CellPrincipalAnnoucements: UICollectionViewCell {
        override init(frame: CGRect){
            super.init(frame: frame)
            backgroundColor = .green
        
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
}
 







class OtherAnnouncementCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        0
//    }
//}

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



