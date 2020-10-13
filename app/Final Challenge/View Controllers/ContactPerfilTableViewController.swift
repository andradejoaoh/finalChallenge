//
//  ContactPerfilTableViewController.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 07/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class ContactPerfilTableViewController: UITableViewController {

    @IBOutlet var contactPerfilTableView: UITableView!
    @IBOutlet weak var contactCell: UITableViewCell!
    @IBOutlet weak var perfilCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        self.contactPerfilTableView.isScrollEnabled = false
        
        self.contactPerfilTableView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        self.contactPerfilTableView.layer.cornerRadius = 15
        self.contactPerfilTableView.separatorInset.left = 50
        
        self.contactCell.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        self.perfilCell.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        self.contactCell.layer.cornerRadius = 15
        self.perfilCell.layer.cornerRadius = 15
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    
    
    
    
    
    @objc func contactShowAction() {
        let slideContactVC = ContactModalViewController()
        slideContactVC.modalPresentationStyle = .custom
        slideContactVC.transitioningDelegate = self
        self.present(slideContactVC, animated: true, completion: nil)
    }
    
    @IBAction func contactShowAction(_ sender: Any) {
        contactShowAction()
    }

}


extension ContactPerfilTableViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
