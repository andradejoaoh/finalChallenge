//
//  HomeViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 03/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CollectionViewCellDelegate, WaterfallLayoutDelegate {
    
    var comeFromPortifolio: Bool = false //ARRUMAR AS SEGUES DE PORTIFOLIO
    var selectedAnnoucement:Int?
    
    var userProfile: User?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var annouceButton: UIButton!
    
    let profileCollectionView: UICollectionView = {
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
    
    let imagePerfil: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "placeholder1"))
        image.frame.size.width = 52
        image.frame.size.height = 52
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
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
        let categoryLabel = UILabel()
        categoryLabel.text = "Descrição - Lorem ipsum dolor sit amet. Ut autem dolores ea quia omnis eos eveniet facilis in possimus dicta"
        categoryLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        categoryLabel.textColor = .black
        return categoryLabel
    }()
    
    let contactButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        button.setTitle("Contato", for: .normal)
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
        button.frame.size.width = 103
        button.frame.size.height = 30
        button.layer.cornerRadius = 15
        return button
    }()
    
    let redesSociaisButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        button.setTitle("Redes Sociais", for: .normal)
        button.frame.size.width = 103
        button.frame.size.height = 30
        button.layer.cornerRadius = 15
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElementsViewDidLoad()
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
        super.viewWillAppear(true)
        setupViewWillAppear()
        
        self.comeFromPortifolio = false//ARRUMAR AS SEGUES DE PORTIFOLIO
        
        if let user = userProfile {
            bio.text = user.userBio
        }
    }

    @IBAction func signOutAction(_ sender: Any) {
        let signOutAlert = UIAlertController(title: "Deseja Sair?", message: "Você poderá fazer login quando quiser novamente", preferredStyle: .alert)
        signOutAlert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        signOutAlert.addAction(UIAlertAction(title: "Sair", style: .destructive, handler: { (UIAlertAction) in
            DatabaseHandler.signOut()
            if let homeProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: HardConstants.Storyboard.homeProfileViewController), let navigationController = self.navigationController{
                navigationController.setViewControllers([homeProfileViewController], animated: true)
            }
        }))
        self.present(signOutAlert, animated: true, completion: nil)
    }
    
    func setupViewWillAppear() {
        if let user = self.userProfile {
            DatabaseHandler.getProfileImage(userID: user.userID) { result in
                switch result {
                case let .success(data):
                    self.profileImageView.image = UIImage(data: data)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func setupElementsViewDidLoad(){
        profileCollectionView.dataSource = self
        profileCollectionView.delegate = self
        
        view.addSubview(profileCollectionView)
        
        
        profileCollectionView.register(AnnoucementPerfilInfoCell.self, forCellWithReuseIdentifier: HardConstants.CollectionView.annoucementPerfilInfoCell)
        profileCollectionView.register(AnnoucementPerfilCell.self, forCellWithReuseIdentifier: HardConstants.CollectionView.annoucementPerfilCell)
        profileCollectionView.register(AnnoucementPortifolioCell.self, forCellWithReuseIdentifier: HardConstants.CollectionView.annoucementPortifolioCell)
        
        
        
        profileCollectionView.register(HeaderPerfilCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HardConstants.CollectionView.headerPerfilView)
        
        profileCollectionView.translatesAutoresizingMaskIntoConstraints = false
        profileCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        profileCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        profileCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        profileCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        profileCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        profileCollectionView
        
        let layout = WaterfallLayout()
        layout.delegate = self
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.headerHeight = 50.0
        profileCollectionView.collectionViewLayout = layout
    }
    
    
    var annoucements: [Annoucement] = []{
        didSet{
            profileCollectionView.reloadData()
        }
    }
    
    var imageLiteralArray = [#imageLiteral(resourceName: "placeholder1"), #imageLiteral(resourceName: "placeholder2"), #imageLiteral(resourceName: "placeholder3"), #imageLiteral(resourceName: "placeholder4"), #imageLiteral(resourceName: "placeholder1"), #imageLiteral(resourceName: "placeholder2"), #imageLiteral(resourceName: "placeholder3"), #imageLiteral(resourceName: "placeholder4"), #imageLiteral(resourceName: "placeholder1")]

    var imagesAnnounced: [String]? {
        didSet{
            profileCollectionView.reloadData()
        }
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {//perfil info
            return 1
        } else if section == 1 {// annoucements
            return annoucements.count
        } else {
            return 1
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {//PERFIL
            guard let cellPerfilInfo = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.annoucementPerfilInfoCell, for: indexPath) as? AnnoucementPerfilInfoCell else { return UICollectionViewCell()}
            cellPerfilInfo.layer.cornerRadius = 10
            return cellPerfilInfo
            
        } else if indexPath.section == 1 {//ANNOUCEMENT
            guard let cellPerfilAnnoucement = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.annoucementPerfilCell, for: indexPath) as? AnnoucementPerfilCell else { return UICollectionViewCell()}
           
            let imageName = imageLiteralArray[indexPath.item]
            cellPerfilAnnoucement.imageAnnoucements.image = imageName
            return cellPerfilAnnoucement
        } else {//PORTIFOLIO
            
            guard let cellPortifolioAnnoucement = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.annoucementPortifolioCell, for: indexPath) as? AnnoucementPortifolioCell else { return UICollectionViewCell()}
            cellPortifolioAnnoucement.delegate = self
            
            return cellPortifolioAnnoucement
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedAnnoucement = indexPath.item
            performSegue(withIdentifier: HardConstants.Storyboard.annoucementSegue, sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {//Info
            return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height)*0.3)
        } else if indexPath.section == 1 {//annoucements
            return CGSize(width: (imageLiteralArray[indexPath.item].size.width), height: (imageLiteralArray[indexPath.item].size.height))
        } else {
            return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height)*0.2)
        }
    }
    
    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {
        if section == 0 {//
            return .flow(column: 1)
        } else if section == 1{
            return .waterfall(column: 2, distributionMethod: .balanced)
        } else {
            return .flow(column: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HardConstants.CollectionView.headerPerfilView, for: indexPath) as! HeaderPerfilCollectionView
            switch indexPath.section{
            case 1:
                headerView.labelHeader.text = "Anúncios"
            case 2:
                headerView.labelHeader.text = "Portifólio"
            default:
                headerView.labelHeader.text = "Header Unknown"
            }
            return headerView
        default:
            preconditionFailure("Invalid supplementary view type for this collection view")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//ARRUMAR AS SEGUES DE PORTIFOLIO
        if let annoucementViewController = segue.destination as? AnnoucementViewController {
            if comeFromPortifolio{
                annoucementViewController.annoucement = annoucements[selectedAnnoucement ?? 0]
                //TODO - mudar para paid annoucements
            } else {
                annoucementViewController.annoucement = annoucements[selectedAnnoucement ?? 0]
            }
            
        }
    }
    
    func collectionViewCell(_ announcementNumber: Int) {
        self.selectedAnnoucement = announcementNumber
        self.comeFromPortifolio = true
        performSegue(withIdentifier: HardConstants.Storyboard.annoucementSegue, sender: self)
    }
    
    
}
