//
//  SignUpViewControllerImagemPerfil.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 11/11/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewControllerImagemPerfil: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var avanceButton: UIButton!
    
    @IBOutlet weak var adicioneImagemButton: UIButton!
    
    @IBOutlet weak var pularButton: UIButton!
    @IBOutlet weak var pageControler: UIPageControl!
    
    @IBOutlet weak var imagemPerfil: UIImageView!
    
    var imagePlaceholder = UIImage(named: "plaholderPerfilImage")
    
    @IBOutlet weak var constraintImagemPerfilToAvancebutton: NSLayoutConstraint!
    
    
    let imagePicker = UIImagePickerController()
    
    var fullname = String()
    var bio = String()
    var email = String()
    var senha = String()
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupStyleForElements()
        imagePicker.delegate = self
        imagemPerfil.isHidden = true
        avanceButton.isHidden = true
        self.hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @IBAction func selectImage(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.imagemPerfil.image = image
        self.imagemPerfil.isHidden = false
        self.avanceButton.isHidden = false
        self.pularButton.isHidden = true
        self.adicioneImagemButton.setTitle("Trocar imagem", for: .normal)
        self.constraintImagemPerfilToAvancebutton.constant = 16.0
        self.view.setNeedsUpdateConstraints()
        self.view.layoutIfNeeded()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //style for elements
    func setupStyleForElements(){
        adicioneImagemButton.backgroundColor = UIColor(named: "button")
        adicioneImagemButton.layer.cornerRadius = 15
        avanceButton.backgroundColor = UIColor(named: "button")
        avanceButton.layer.cornerRadius = 15
        imagemPerfil.layer.cornerRadius = 10
        pageControler.currentPage = 3
    }
    
    @IBAction func unwindToImagePerfilContent(segue:UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "avanceSegueToCategoria" {
            let destinationControler = segue.destination as! SignUpViewControllerCategoria
            destinationControler.fullname = fullname
            destinationControler.bio = bio
            destinationControler.email = email
            destinationControler.senha = senha
            destinationControler.name = name
            destinationControler.image = imagemPerfil
        } else if segue.identifier == "pularSegueToCategoria" {
            let destinationControler = segue.destination as! SignUpViewControllerCategoria
            destinationControler.fullname = fullname
            destinationControler.bio = bio
            destinationControler.email = email
            destinationControler.senha = senha
            destinationControler.name = name
            destinationControler.image = UIImageView(image: imagePlaceholder)
        } else if segue.identifier == "swipeSegueToCategoria" && imagemPerfil != nil{
            let destinationControler = segue.destination as! SignUpViewControllerCategoria
            destinationControler.fullname = fullname
            destinationControler.bio = bio
            destinationControler.email = email
            destinationControler.senha = senha
            destinationControler.name = name
            destinationControler.image = imagemPerfil
        } else if segue.identifier == "swipeSegueToCategoria" && imagemPerfil == nil {
            let destinationControler = segue.destination as! SignUpViewControllerCategoria
            destinationControler.fullname = fullname
            destinationControler.bio = bio
            destinationControler.email = email
            destinationControler.senha = senha
            destinationControler.name = name
            destinationControler.image = UIImageView(image: imagePlaceholder)
        }
    }
    
    //avanceSegueToCategoria
    
    //pularSegueToCategoria
    
    //swipeSegueToCategoria
    
    //unwindToBemVindo

}

