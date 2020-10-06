//
//  AnnoucementViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 23/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class AnnoucementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate {
    
    
    var annoucement: Annoucement?
    var user: User?
    
    @IBOutlet weak var annoucementImage: UIImageView!
    @IBOutlet weak var annoucementName: UILabel!
    @IBOutlet weak var annoucementDescription: UILabel!
    @IBOutlet weak var annoucementPrice: UILabel!
    @IBOutlet weak var contactPerfilTableView: UITableView!
    
    let contactPerfilLabelArray: [String] = ["Contato", "Perfil"]
    let contactPerfilImagesArray: [UIImage] = [#imageLiteral(resourceName: "contactIconPhone"), #imageLiteral(resourceName: "contactIconPhone")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
    }
    
    func setupView() {
        if let annoucement = self.annoucement {
            annoucementName.text = annoucement.annoucementName
            annoucementDescription.text = annoucement.description
            annoucementImage.image = UIImage(data: annoucement.imageData ?? Data())
        }
        self.contactPerfilTableView.delegate = self
        self.contactPerfilTableView.dataSource = self
        self.contactPerfilTableView.isScrollEnabled = false
        
        self.contactPerfilTableView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        self.contactPerfilTableView.layer.cornerRadius = 10
    }
    
    @IBAction func optionsAction(_ sender: Any) {
        let actionSheet = createActionSheet()
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editAnnoucementViewController = segue.destination as? EditAnnoucementViewController {
            editAnnoucementViewController.annoucement = self.annoucement
        }
        if let profileViewController = segue.destination as? ProfileViewController {
            profileViewController.userProfile = user
        }
    }
    
    func createActionSheet() -> UIAlertController{
        let actionSheet = UIAlertController(title: "Opções", message: "Selecione uma opção", preferredStyle: .actionSheet)
        if DatabaseHandler.getCurrentUser() == annoucement?.userID {
            
            actionSheet.addAction(UIAlertAction(title: "Editar", style: .default, handler: { (UIAlertAction) in
                self.performSegue(withIdentifier: HardConstants.Storyboard.editSegue, sender: self)
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Deletar", style: .destructive, handler: { (UIAlertAction) in
                self.deleteAnnoucement()
            }))
        } else {
            actionSheet.addAction(UIAlertAction(title: "Ver Perfil", style: .default, handler: { (UIAlertAction) in
                guard self.user != nil else { return }
                self.performSegue(withIdentifier: HardConstants.Storyboard.annoucementProfileSegue, sender: self)
                
            }))
            actionSheet.addAction(UIAlertAction(title: "Denunciar", style: .destructive, handler: { (UIAlertAction) in
                print("Denunciar")
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        return actionSheet
    }
    
    func deleteAnnoucement() {
        let deleteAlert = UIAlertController(title: "Deseja deletar seu anúncio?", message: "Essa ação não poderá ser desfeita, mas você sempre pode anunciar novamente.", preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        deleteAlert.addAction(UIAlertAction(title: "Deletar", style: .destructive, handler: { (UIAlertAction) in
            guard let annoucement = self.annoucement else { return }
            DatabaseHandler.deleteAnnoucement(annoucementID: annoucement.annoucementID) { (result) in
                switch result {
                case .failure:
                    break
                case .success:
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }))
        self.present(deleteAlert, animated: true, completion: nil)
    }
    func getUserData() {
        guard let annoucement = self.annoucement else { return }
        DatabaseHandler.getData(for: annoucement.userID, completion: { (result) in
            switch result{
            case let .success(user):
                self.user = user
            case let .failure(err):
                print(err)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = contactPerfilTableView.dequeueReusableCell(withIdentifier: HardConstants.TableView.contactPerfilCell, for: indexPath) as? AnnoucementDetailTableViewCell else { return UITableViewCell()}
        cell.labelCell.text = contactPerfilLabelArray[indexPath.row]
        cell.imagesCell.image = contactPerfilImagesArray[indexPath.row]
        //self.contactPerfilTableView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)

        cell.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        return cell
        
        //guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.annoucementCellSection, for: indexPath) as? annoucementCellForSection else { return UICollectionViewCell()}
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
        }
        else if indexPath.row == 1 {
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
