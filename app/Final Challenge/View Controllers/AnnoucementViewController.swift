//
//  AnnoucementViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 23/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class AnnoucementViewController: UIViewController, UIActionSheetDelegate {
    
    
    var annoucement: Annoucement?
    
    @IBOutlet weak var annoucementImage: UIImageView!
    @IBOutlet weak var annoucementName: UILabel!
    @IBOutlet weak var annoucementDescription: UILabel!
    @IBOutlet weak var annoucementPrice: UILabel!
    
    @IBOutlet weak var diponibilityLabel: UILabel!
    
    @IBOutlet weak var bairroLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            categoryLabel.text = annoucement.productType
            let range = DateInterval(start: Date(), end: annoucement.expirationDate ?? Date())
            if range.duration > 3600{
                let hours = Int(range.duration/3600)
                let minutes = Int((range.duration.truncatingRemainder(dividingBy: 3600)/60))
                diponibilityLabel.text = "Disponível por \(hours) horas e \(minutes) minutos"
            } else if range.duration > 100 && range.duration < 3600 {
                let minutes = Int((range.duration.truncatingRemainder(dividingBy: 3600)/60))
                diponibilityLabel.text = "Disponível por \(minutes) minutos"
            } else {
                diponibilityLabel.text = "Informações sobre disponibilidade não encontradas"
            }
        }
        annoucementPrice.layer.backgroundColor = #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6980392157, alpha: 1)
        annoucementPrice.layer.cornerRadius = 15
    }
    
    @IBAction func optionsAction(_ sender: Any) {
        let actionSheet = createActionSheet()
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case HardConstants.Storyboard.annoucementProfileSegue:
            guard let profileViewController = segue.destination as? ProfileViewController else { return }
                profileViewController.userProfile = annoucement?.user
            
        case HardConstants.Storyboard.editSegue:
            guard let editAnnoucementViewController = segue.destination as? EditAnnoucementViewController else { return }
            editAnnoucementViewController.annoucement = self.annoucement
            
        default:
            return
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
            actionSheet.addAction(UIAlertAction(title: "Denunciar", style: .destructive, handler: { (UIAlertAction) in
                print("Denunciar")
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        return actionSheet
    }
    
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    func toProfile(){
        guard self.annoucement?.user != nil else { return }
        self.performSegue(withIdentifier: HardConstants.Storyboard.annoucementProfileSegue, sender: self)
    }
    
    func contactUser(){
        self.present(createContactController(), animated: true, completion: nil)
    }
    
    @IBAction func buyButtonAction(_ sender: Any) {
        contactUser()
    }
    
    @IBAction func profileButtonAction(_ sender: Any) {
        toProfile()
    }
    
    
    func createContactController() -> UIAlertController {
        let actionSheet = UIAlertController(title: "Entrar em Contato", message: "Como deseja entrar em contato?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Telefonar", style: .default, handler: { (UIAlertAction) in
            if let url = URL(string: "tel://\(String(describing: self.annoucement?.user?.userPhone))"), UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Mandar um e-mail", style: .default, handler: { (UIAlertAction) in
            if let url = URL(string: "mailto:\(String(describing:  self.annoucement?.user?.userEmail))"){
                if #available(iOS 10.0, *){
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                    
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        return actionSheet
    }
}
