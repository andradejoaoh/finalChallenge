//
//  SignUpViewControllerCategoria.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 11/11/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import UIKit


class SignUpViewControllerCategoria: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
   
    
    
    var email = String()
    var senha = String()
    var name = String()
    var image = UIImageView()
    //nova var para categoria
    var categoriaSelecionada = String()
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var avanceButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var casaBttn: UIButton!
    
    @IBOutlet weak var docesBttn: UIButton!
    
    @IBOutlet weak var roupasBttn: UIButton!
    
    @IBOutlet weak var festaBttn: UIButton!
    
    @IBOutlet weak var comidasBttn: UIButton!
    
    @IBOutlet weak var decoracaoBttn: UIButton!
    
    @IBOutlet weak var acessoriosBttn: UIButton!
    
    @IBOutlet weak var salgadosBttn: UIButton!
    
    @IBOutlet weak var cosmeticosBttn: UIButton!
    
    @IBOutlet weak var educacaoBttn: UIButton!
    
    @IBOutlet weak var papelariaBttn: UIButton!
    
    @IBOutlet weak var saudeBttn: UIButton!
    
    @IBOutlet weak var verTudoButtonOutlet: UIButton!
    
    @IBOutlet weak var heightOfCategoriesView: NSLayoutConstraint!

    @IBOutlet weak var ExpandableCategoryView: UIView!

    
    var casaBttnControl:Bool = false
    var docesBttnControl:Bool = false
    var roupasBttnControl:Bool = false
    var festaBttnControl:Bool = false
    var comidasBttnControl:Bool = false
    var decorationBttnControl:Bool = false
    var acessorioBttnControl:Bool = false
    var salgadosBttnControl:Bool = false
    var cosmeticosBttnControl:Bool = false
    var educacaoBttnControl:Bool = false
    var papelariaBttnControl:Bool = false
    var saudeBttnControl:Bool = false
    
    var arraySelectedState = [Bool]()
    
    var expandableCategoryControl: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupStyleForElements()
        self.scrollView.isScrollEnabled = false
        self.hideKeyboardWhenTappedAround()
        
        arraySelectedState = [casaBttn.isSelected, docesBttn.isSelected, roupasBttn.isSelected, festaBttn.isSelected, comidasBttn.isSelected, decoracaoBttn.isSelected, acessoriosBttn.isSelected, salgadosBttn.isSelected, cosmeticosBttn.isSelected, educacaoBttn.isSelected, papelariaBttn.isSelected, saudeBttn.isSelected]
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        gravaCategory()
    }
    
    @IBAction func expandCategoryButtonAction(_ sender: Any) {
        if expandableCategoryControl == false {
            UIView.animate(withDuration: 0.3) {
                self.scrollView.isScrollEnabled = true
                self.heightOfCategoriesView.constant = 250.0
                self.view.setNeedsUpdateConstraints()
                self.verTudoButtonOutlet.setTitle("Minimizar", for: .normal)
                self.view.layoutIfNeeded()
            }
            expandableCategoryControl = true
        } else {
            UIView .animate(withDuration: 0.3) {
                self.heightOfCategoriesView.constant = 0.0
                self.view.setNeedsUpdateConstraints()
                self.verTudoButtonOutlet.setTitle("Ver tudo", for: .normal)
                self.view.layoutIfNeeded()
            }
            scrollView.setContentOffset(.zero, animated: true)
            expandableCategoryControl = false
            self.scrollView.isScrollEnabled = false
        }
    }
    
    
    @IBAction func casaActionButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        } else {
            sender.isSelected = true
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        }
    }
    
    @IBAction func docesActionButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            casaBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        } else {
            sender.isSelected = true
            casaBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        }
    }
    
    @IBAction func roupasActionButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        } else {
            sender.isSelected = true
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        }
    }
    
    /*
     
     if sender.isSelected {
         sender.isSelected = false
         casaBttn.isSelected = false
         docesBttn.isSelected = false
         roupasBttn.isSelected = false
         festaBttn.isSelected = false
         comidasBttn.isSelected = false
         decoracaoBttn.isSelected = false
         acessoriosBttn.isSelected = false
         salgadosBttn.isSelected = false
         cosmeticosBttn.isSelected = false
         educacaoBttn.isSelected = false
         papelariaBttn.isSelected = false
         saudeBttn.isSelected = false
     } else {
         sender.isSelected = true
         casaBttn.isSelected = false
         docesBttn.isSelected = false
         roupasBttn.isSelected = false
         festaBttn.isSelected = false
         comidasBttn.isSelected = false
         decoracaoBttn.isSelected = false
         acessoriosBttn.isSelected = false
         salgadosBttn.isSelected = false
         cosmeticosBttn.isSelected = false
         educacaoBttn.isSelected = false
         papelariaBttn.isSelected = false
         saudeBttn.isSelected = false
     }
     */
    
    @IBAction func festaActionButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        } else {
            sender.isSelected = true
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        }
    }
    
    @IBAction func comidasActionButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        } else {
            sender.isSelected = true
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        }
    }
    
    @IBAction func decoracaoActionButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        } else {
            sender.isSelected = true
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        }
    }
    @IBAction func acessoriosActionButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        } else {
            sender.isSelected = true
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        }
    }
    
    @IBAction func salgadosActionButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        } else {
            sender.isSelected = true
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        }
    }
    
    @IBAction func cosmeticosActionButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        } else {
            sender.isSelected = true
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        }
    }
    
    @IBAction func educacaoActionButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        } else {
            sender.isSelected = true
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            papelariaBttn.isSelected = false
            saudeBttn.isSelected = false
        }
    }
    
    @IBAction func papelariaActionButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            saudeBttn.isSelected = false
        } else {
            sender.isSelected = true
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            saudeBttn.isSelected = false
        }
    }
    
    @IBAction func saudeActionButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
        } else {
            sender.isSelected = true
            casaBttn.isSelected = false
            docesBttn.isSelected = false
            roupasBttn.isSelected = false
            festaBttn.isSelected = false
            comidasBttn.isSelected = false
            decoracaoBttn.isSelected = false
            acessoriosBttn.isSelected = false
            salgadosBttn.isSelected = false
            cosmeticosBttn.isSelected = false
            educacaoBttn.isSelected = false
            papelariaBttn.isSelected = false
        }
    }
    
    
    
    //style for elements
    func setupStyleForElements(){
        avanceButton.backgroundColor = UIColor(named: "button")
        avanceButton.layer.cornerRadius = 15
        pageControl.currentPage = 3
    }
    
    func gravaCategory(){
        if casaBttn.isSelected {
            categoriaSelecionada = "casa"
        } else if docesBttn.isSelected {
            categoriaSelecionada = "doces"
        } else if roupasBttn.isSelected {
            categoriaSelecionada = "roupas"
        } else if festaBttn.isSelected {
            categoriaSelecionada = "festa"
        } else if decoracaoBttn.isSelected {
            categoriaSelecionada = "decoracao"
        } else if acessoriosBttn.isSelected {
            categoriaSelecionada = "acessorio"
        } else if salgadosBttn.isSelected {
            categoriaSelecionada = "salgados"
        } else if cosmeticosBttn.isSelected {
            categoriaSelecionada = "cosmeticos"
        } else if educacaoBttn.isSelected {
            categoriaSelecionada = "educacao"
        } else if papelariaBttn.isSelected {
            categoriaSelecionada = "papelaria"
        }
        
    }
    
    
    @IBAction func unwindToCategoria(segue:UIStoryboardSegue) {}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        gravaCategory()
        if segue.identifier == "segueToInfoPessoais" || segue.identifier == "swipeSegueToInfoPessoais" {
            let destinationController = segue.destination as! SignUpViewControllerPessoalInfo
            destinationController.email = email
            destinationController.senha = senha
            destinationController.name = name
            destinationController.image = image
            destinationController.categoria = categoriaSelecionada
        } else {}
        
            //let destinationController = segue.destination as! XXXXXX
            //destinationController.email = emailTextField.text!
            //destinationController.senha = passwordTextField.text!
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "unwindToImagePerfil" {
            return true
        } else if (identifier == "segueToInfoPessoais" || identifier == "swipeSegueToInfoPessoais") && (casaBttn.isSelected == false && docesBttn.isSelected == false && roupasBttn.isSelected == false && festaBttn.isSelected == false && comidasBttn.isSelected == false && decoracaoBttn.isSelected == false && acessoriosBttn.isSelected == false && salgadosBttn.isSelected == false && cosmeticosBttn.isSelected == false && educacaoBttn.isSelected == false && papelariaBttn.isSelected == false && saudeBttn.isSelected == false) {
            return false
        } else {
            gravaCategory()
            return true
        }
    }
    
    
    //segueToInfoPessoais
    
    //swipeSegueToInfoPessoais
    
    //unwindToImagePerfil

    
}


