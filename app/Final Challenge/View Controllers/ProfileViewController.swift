//
//  HomeViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 03/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CollectionViewCellDelegate, WaterfallLayoutDelegate {
    
    
    var userProfile: User?
    var annoucements: [Annoucement] = []{
        didSet{
            profileCollectionView.reloadData()
        }
    }
    var selectedAnnoucement: Int = 0
    
    
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
    
    let imagePerfil: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "placeholder3"))
        image.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
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
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Descrição - Lorem ipsum dolor sit amet. Ut autem dolores ea quia omnis eos eveniet facilis in possimus dicta"
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    let contactButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        button.setTitle("Contato", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
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
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.frame.size.width = 103
        button.frame.size.height = 30
        button.layer.cornerRadius = 15
        return button
    }()
    
    let redesSociaisButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        button.setTitle("Redes Sociais", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.frame.size.width = 103
        button.frame.size.height = 30
        button.layer.cornerRadius = 15
        return button
    }()
    
    let createAnnoucementButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        button.setTitle("Criar Anúncio", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.frame.size.width = 103
        button.frame.size.height = 30
        button.layer.cornerRadius = 15
        return button
    }()
    
    let sairButtonProvisorio: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 0.6547823548, blue: 0.6713048816, alpha: 1)
        button.setTitle("Sair", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Nome do perfil"
        setupElementsViewDidLoad()
        setupElementsInCollectionView()
        DatabaseHandler.readAnnoucements { (result) in
            switch result {
            case let .failure(error):
                //Show error while updating feed
                print(error)
            case let .success(annoucements):
                self.annoucements = annoucements.filter{ $0.userID == self.userProfile?.userID}
            }
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
    }
    
    func setupView() {
        let defaults = UserDefaults()
        if let user = self.userProfile {
            
            
            
            if user.userID != DatabaseHandler.getCurrentUser() {
                sairButtonProvisorio.isHidden = true
                createAnnoucementButton.isHidden = true
            } else {
                sairButtonProvisorio.isHidden = false
                createAnnoucementButton.isHidden = false
            }
            
            DatabaseHandler.getProfileImage(userID: user.userID) { result in
                switch result {
                case let .success(data):
                    self.imagePerfil.image = UIImage(data: data)
                case let .failure(error):
                    print(error)
                }
            }
        }
        guard case descriptionLabel.text = defaults.value(forKey: "userBio") as? String else { return }
    }
    
    
    func createAlertController() -> UIAlertController {
        let actionSheet = UIAlertController(title: "Entrar em Contato", message: "Como deseja entrar em contato?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Telefonar", style: .default, handler: { (UIAlertAction) in
            if let url = URL(string: "tel://\(String(describing: self.userProfile?.userPhone))"), UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Mandar um e-mail", style: .default, handler: { (UIAlertAction) in
            if let url = URL(string: "mailto:\(String(describing: self.userProfile?.userEmail))"){
                if #available(iOS 10.0, *){
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                    
                }
            }
        }))
        return actionSheet
    }
    
    func setupElementsInCollectionView(){
        profileCollectionView.addSubview(imagePerfil)
        profileCollectionView.addSubview(perfilNameLabel)
        profileCollectionView.addSubview(categoryLabel)
        profileCollectionView.addSubview(bairroLabel)

        profileCollectionView.addSubview(descriptionLabel)
        profileCollectionView.addSubview(contactButton)
        profileCollectionView.addSubview(siteButton)
        profileCollectionView.addSubview(redesSociaisButton)
        
        
        profileCollectionView.addSubview(createAnnoucementButton)
        profileCollectionView.addSubview(sairButtonProvisorio)
        
        imagePerfil.translatesAutoresizingMaskIntoConstraints = false
        imagePerfil.topAnchor.constraint(equalTo: self.profileCollectionView.topAnchor, constant: 16).isActive = true
        imagePerfil.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        imagePerfil.heightAnchor.constraint(equalToConstant: CGFloat(52)).isActive = true
        imagePerfil.widthAnchor.constraint(equalToConstant: CGFloat(52)).isActive = true
        
        perfilNameLabel.translatesAutoresizingMaskIntoConstraints = false
        perfilNameLabel.topAnchor.constraint(equalTo: self.profileCollectionView.topAnchor, constant: 16).isActive = true
        perfilNameLabel.leftAnchor.constraint(equalTo: self.imagePerfil.rightAnchor, constant: 10).isActive = true
        perfilNameLabel.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        
    
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.topAnchor.constraint(equalTo: self.perfilNameLabel.bottomAnchor, constant: 0).isActive = true
        categoryLabel.leftAnchor.constraint(equalTo: self.imagePerfil.rightAnchor, constant: 10).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        
        bairroLabel.translatesAutoresizingMaskIntoConstraints = false
        bairroLabel.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 0).isActive = true
        bairroLabel.leftAnchor.constraint(equalTo: self.imagePerfil.rightAnchor, constant: 10).isActive = true
        bairroLabel.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        contactButton.topAnchor.constraint(equalTo: self.imagePerfil.bottomAnchor, constant: 18).isActive = true
        contactButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        contactButton.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        contactButton.widthAnchor.constraint(equalToConstant: self.view.frame.width/3 * 0.88).isActive = true
        
        siteButton.translatesAutoresizingMaskIntoConstraints = false
        siteButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        siteButton.topAnchor.constraint(equalTo: self.imagePerfil.bottomAnchor, constant: 18).isActive = true
        siteButton.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        siteButton.widthAnchor.constraint(equalToConstant: self.view.frame.width/3 * 0.88).isActive = true
        
        redesSociaisButton.translatesAutoresizingMaskIntoConstraints = false
        redesSociaisButton.topAnchor.constraint(equalTo: self.imagePerfil.bottomAnchor, constant: 18).isActive = true
        redesSociaisButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        redesSociaisButton.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        redesSociaisButton.widthAnchor.constraint(equalToConstant: self.view.frame.width/3 * 0.88).isActive = true
        
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: self.siteButton.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        
        
        sairButtonProvisorio.translatesAutoresizingMaskIntoConstraints = false
        sairButtonProvisorio.topAnchor.constraint(equalTo: self.profileCollectionView.topAnchor, constant: self.view.frame.size.height * 0.3).isActive = true
        sairButtonProvisorio.centerXAnchor.constraint(equalTo: self.profileCollectionView.centerXAnchor, constant: 0).isActive = true
        sairButtonProvisorio.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        sairButtonProvisorio.widthAnchor.constraint(equalToConstant: CGFloat(self.view.frame.size.width * 0.5)).isActive = true
        
        createAnnoucementButton.translatesAutoresizingMaskIntoConstraints = false
        createAnnoucementButton.topAnchor.constraint(equalTo: sairButtonProvisorio.bottomAnchor, constant: 10).isActive = true
        createAnnoucementButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        createAnnoucementButton.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        createAnnoucementButton.widthAnchor.constraint(equalToConstant: CGFloat(self.view.frame.size.width * 0.90)).isActive = true
        
        
        contactButton.addTarget(self, action: #selector(contactButtonTapped), for: UIControl.Event.touchUpInside)
        siteButton.addTarget(self, action: #selector(siteButtonTapped), for: UIControl.Event.touchUpInside)
        redesSociaisButton.addTarget(self, action: #selector(redesSociaisButtonTapped), for: UIControl.Event.touchUpInside)
        createAnnoucementButton.addTarget(self, action: #selector(createAnnoucementButtonTapped), for: UIControl.Event.touchUpInside)
        sairButtonProvisorio.addTarget(self, action: #selector(sairButtonActionTapped), for: UIControl.Event.touchUpInside)
        
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
        
        let layout = WaterfallLayout()
        layout.delegate = self
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 10)
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.headerHeight = 50.0
        profileCollectionView.collectionViewLayout = layout
        
        profileCollectionView.isUserInteractionEnabled = true
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
    
    
    
    @objc func contactButtonTapped() -> Void {
        guard let user = self.userProfile else { return }
        let contactAlert = ContactHandler.createContactController(to: user)
        self.present(contactAlert, animated: true, completion: nil)
    }
    
    @objc func siteButtonTapped() -> Void {
        print("Site Button")
    }
    
    @objc func redesSociaisButtonTapped() -> Void {
        print("Redes Sociais  Button")
    }
    
    @objc func createAnnoucementButtonTapped() -> Void {
        print("Create announcement Button")
    }
    
    @objc func sairButtonActionTapped() -> Void {
        let signOutAlert = UIAlertController(title: "Deseja Sair?", message: "Você poderá fazer login quando quiser novamente.", preferredStyle: .alert)
        signOutAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        signOutAlert.addAction(UIAlertAction(title: "Sair", style: .destructive, handler: { (UIAlertAction) in
            DatabaseHandler.signOut()
            if let homeProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: HardConstants.Storyboard.homeProfileViewController), let navigationController = self.navigationController{
                navigationController.setViewControllers([homeProfileViewController], animated: true)
            }
        }))
        self.present(signOutAlert, animated: true, completion: nil)
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
            return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height)*0.45)
        } else if indexPath.section == 1 {//annoucements
            return CGSize(width: (imageLiteralArray[indexPath.item].size.width), height: (imageLiteralArray[indexPath.item].size.height))
        } else {
            return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height)*0.2)
        }
    }
    
    
    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {
        if section == 1 {//
            return .waterfall(column: 2, distributionMethod: .balanced)
        } else if section == 2{
            return .flow(column: 1)
        } else {
            return .flow(column: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, estimatedSizeForItemAt indexPath: IndexPath) -> CGSize? {
        let width = profileCollectionView.frame.size.width
        let height = profileCollectionView.frame.size.height
        if indexPath.section == 0 {
            
            return CGSize(width: width, height: height)
        }
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HardConstants.CollectionView.headerPerfilView, for: indexPath) as! HeaderPerfilCollectionView
            switch indexPath.section{
            case 0:
                //headerView.frame.size.height = 0
                headerView.labelHeader.text = ""
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
    
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, headerHeightFor section: Int) -> CGFloat? {
        let headerHeight: CGFloat

        switch section {
        case 0:
            headerHeight = 10
            //headerHeight = CGFloat.leastNonzeroMagnitude
        default:
            headerHeight = 30
        }
        return headerHeight
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//ARRUMAR AS SEGUES DE PORTIFOLIO
        if let annoucementViewController = segue.destination as? AnnoucementViewController {
                annoucementViewController.annoucement = annoucements[selectedAnnoucement]
        }
    }
    
    func collectionViewCell(_ announcementNumber: Int) {
        self.selectedAnnoucement = announcementNumber
        performSegue(withIdentifier: HardConstants.Storyboard.fromProfileToAnnoucementSegue, sender: self)
    }
}
